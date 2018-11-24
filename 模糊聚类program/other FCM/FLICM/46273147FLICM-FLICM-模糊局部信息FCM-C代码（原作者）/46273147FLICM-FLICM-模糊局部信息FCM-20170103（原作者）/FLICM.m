#include "mex.h"
#include <math.h>
#include <limits.h>



double** mallocdbl2( unsigned long i, unsigned long j ){
	double **m;
	unsigned long ii;

	m = (double**)malloc( (unsigned long)i*sizeof(double*) );
	for( ii=0; ii<i; ii++ )
		m[ii] = (double*)malloc( (unsigned long)j*sizeof(double) );
	return m;
}


double*** mallocdbl3(unsigned long c, unsigned long i, unsigned long j){
	double ***m;
	unsigned long cc, ii;

	m = (double***)malloc( (unsigned long)c*sizeof(double**) );
	for(cc=0; cc<c; cc++){
		m[cc] = (double**)malloc( (unsigned long)i*sizeof(double*) );
		for( ii=0; ii<i; ii++ )
			m[cc][ii] = (double*)malloc( (unsigned long)j*sizeof(double) );
	}
	return m;
}


void mfreedbl2( double **m, unsigned long i ){
	unsigned long ii;
	for( ii=0; ii<i; ii++ )
		free( (double*)m[ii] );
	free( (double**)m );
}


void mfreedbl3( double ***m, unsigned long c, unsigned long i ){
	unsigned long cc, ii;
	for( cc=0; cc<c; cc++ ){
		for( ii=0; ii<i; ii++ )
			free( (double*)m[cc][ii] );
		free( (double**)m[cc] );
	}
	free( (double***)m );
}



void CalcCenters( double **image, long height, long width, double ***U, long cNum, double m, double *c ){
	long i, j, k;
	double sSum;

	for( k=0; k<cNum; k++ ){
		c[k] = 0.0;
		sSum = 0.0;
		for( i=0; i<height; i++ )
			for( j=0; j<width; j++ ){
				sSum += pow( U[i][j][k], m );
				c[k] += pow(U[i][j][k],m) * image[i][j];
			}
		c[k] /= sSum;
	}
}



void FLICM_alg( double *img, long height, long width, double *Uinit, double m, long cNum, long winSize, long maxIter, double thrE, double *Uout, double *iter ){
	long i, j, k, ii, jj, x, y, sweeps, sStep;
	double **image, ***U, ***Uold, *c, *d, dd, vec;
	double dMax, sSum, dist;

	// memory allocations and initializations.
	sStep = (winSize-1)/2;
	image = mallocdbl2( height, width );
	Uold  = mallocdbl3( height, width, cNum );
	U     = mallocdbl3( height, width, cNum );
	c     = (double*)malloc( cNum*sizeof(double) );
	d     = (double*)malloc( cNum*sizeof(double) );
	for( i=0; i<height; i++ )
		for( j=0; j<width; j++ ){
			image[i][j] = img[j*height+i];
			for( k=0; k<cNum; k++ ){
				U[i][j][k] = Uinit[k*height*width + j*height + i];
				Uold[i][j][k] = U[i][j][k];
			}
		}
	CalcCenters( image, height, width, U, cNum, m, c );

	sweeps = 0;
	dMax = 10.0;
	while( dMax>thrE && sweeps<=maxIter ){
		// Calculation of the new array U.
		for( i=0; i<height; i++ ){
			for( j=0; j<width; j++ ){
				// for each center.
				for( k=0; k<cNum; k++ ){
					vec = image[i][j];
					sSum = fabs( vec-c[k] );
					for( ii=-sStep; ii<=sStep; ii++ )
						for( jj=-sStep; jj<=sStep; jj++ ){
							x = j + jj;
							y = i + ii;
							dist = sqrt( (x-j)*(x-j) + (y-i)*(y-i) );
							if( x>=0 && x<width && y>=0 && y<height && (ii!=0 || jj!=0) ){
								vec = image[y][x];
								sSum += 1.0/(1.0+dist)*pow(1.0-Uold[y][x][k],m) * fabs(vec-c[k]);
							}
						}
					d[k] = sSum;
				}

				for( k=0; k<cNum; k++ ){
					dd = d[k];
					sSum = 0.0;
					for( ii=0; ii<cNum; ii++ )
						sSum += pow( dd/d[ii], 1.0/(m-1.0));
					U[i][j][k] = 1.0 / sSum;
				}
			}
		}

		// New center calculation.
		CalcCenters( image, height, width, U, cNum, m, c );

		dMax = -1.0;
		// Copy new array U to old one.
		for( i=0; i<height; i++ )
			for( j=0; j<width; j++ )
				for( k=0; k<cNum; k++ ){
					if( dMax<fabs(Uold[i][j][k]-U[i][j][k]) )
						dMax = fabs(Uold[i][j][k]-U[i][j][k]);
					Uold[i][j][k] = U[i][j][k];
					Uout[k*height*width + j*height + i] = U[i][j][k];
				}
		sweeps++;
	}
	iter[0] = sweeps;

	mfreedbl2( image, height );
	mfreedbl3( Uold, height, width );
	mfreedbl3( U, height, width );
	free( (double*)c );
	free( (double*)d );
}



void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[] ){
	int H, W, m, cNum, winSize, maxIter, dims[3];
	double *img, *U, *Uout, *iter, thrE;

	/* Extract the inputs */
	img  = mxGetPr(prhs[0]);
	H    = (int)mxGetScalar(prhs[1]);
	W    = (int)mxGetScalar(prhs[2]);
	U    = mxGetPr(prhs[3]);
	m    = (double)mxGetScalar(prhs[4]);
	cNum = (int)mxGetScalar(prhs[5]);
	winSize = (int)mxGetScalar(prhs[6]);
	maxIter = (int)mxGetScalar(prhs[7]);
	thrE    = (double)mxGetScalar(prhs[8]);

	/* Setup the output */
	dims[0] = H;	dims[1] = W;	dims[2] = cNum;
	plhs[0] = mxCreateNumericArray(3,dims,mxDOUBLE_CLASS,mxREAL);
	Uout = mxGetPr(plhs[0]);
	plhs[1] = mxCreateDoubleMatrix(1,1,mxREAL);
	iter = mxGetPr(plhs[1]);

	/* Do the actual work */
	FLICM_alg(img, H, W, U, m, cNum, winSize, maxIter, thrE, Uout, iter);
}
