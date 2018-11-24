function [imOut,iter] = FLICM_clustering( imgFileName, cNum, m, winSize, maxIter, thrE )
%FLICM_clustering
%
% Usage:   [imOut,iter] = FLICM_clustering( imgFileName, cNum, m, winSize, maxIter, thrE )
% Inputs: 
%   imgFilename    Filename of the input image.
%   cNum           Number of clusters.
%   m              Weighting exponent on each fuzzy membership.
%   winSize        Size of the local window.
%   maxIter        Maximum number of iterations.
%   thrE           Threshold that stops the algorithm.
% Outputs:
%   imOut          The clustered image.
%   iter           The number of iterations made by the algorithm.
%
% Running example:
%   [imOut,iter] = FLICM_clustering('brain.tif',3,2,3,500,0.001);
%   figure, imshow(imOut)
%
%   author: Krinidis Stelios
%   19/04/2011 to run on Matlab 7.0.0.19920 (R14) Service Pack 1


% Load image
image = imread( imgFileName );
if( size(image,3)>1 )
    image = rgb2gray( image );
end
image = double( image );

% Initialize randomly the memberships array U
[H,W] = size( image );
U = rand( H, W, cNum-1 )*(1/cNum);
U(:,:,cNum) = 1 - sum(U,3);

% FLICM
[U,iter] = FLICM( image, H, W, U, m, cNum, winSize, maxIter, thrE );

% Create output image
cmap = hsv(cNum);
[mMax,clus] = max( U, [], 3 );
Ir = zeros(size(image));    Ig = zeros(size(image));    Ib = zeros(size(image));
for i=1:cNum
    q = find( clus==i );
    Ir(q) = round(cmap(i,1)*255);
    Ig(q) = round(cmap(i,2)*255);
    Ib(q) = round(cmap(i,3)*255);
end
imOut(:,:,1) = uint8(Ir);
imOut(:,:,2) = uint8(Ig);
imOut(:,:,3) = uint8(Ib);
