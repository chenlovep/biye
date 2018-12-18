Matlab software for FLICM algorithm

Authors: Stelios Krinidis and Vassilios Chatzis

Emails: stelios.krinidis@mycosmos.gr and chatzis@teikav.edu.gr

This software implements the approach presented in

S. Krinidis and V. Chatzis: A Robust Fuzzy Local Information C-means Clustering Algorithm.
IEEE Trans. on Image Processing (TIP), vol. 19, no. 5, pp. 1328-1337, May 2010.

Please cite this paper when using this software.

Important Notices: 

1. The code is not optimized, so the running time could be more than the expected.
2. Thank you again for using this software.



Using the code:

Everything was done in Matlab and MEX (i.e. a C function callable from Matlab).
First, the C code needs to be compiled.  At the Matlab prompt, type:

   mex FLICM.c

Now the code is ready to run. A running example you can see in
test_FLICM.m
