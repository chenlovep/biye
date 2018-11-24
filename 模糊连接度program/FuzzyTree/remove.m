function y=remove(x,idx)
%function y=remove(x,idx)
% Kind of inverse to find
%Author: Joakim Lindblad

m=ones(size(x));
m(idx)=0;
y=x(find(m));
