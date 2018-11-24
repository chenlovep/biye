function h=imoverlay(I,mask,alpha,c,map)
%function h=imoverlay(I,mask=[],alpha=0.5,contour=true,map=jet)
%
% Overlay bw image I in range [0,1] on top of existing rgb image
% If max(I(:)) > 1, then I is divided by max
%
%Author: Joakim Lindblad

if nargin<2
	mask=[];
end
if nargin<3
	alpha=0.5;
end
if nargin<4
	c=true;
end
if nargin<5
	map=jet(64);
end
disp(size(map));
%将图像I进行归一化处理
if max(I(:))>1
	I=I./max(I(:));
end

hold on
h = image(ind2rgb(round(I.*size(map,1)),map));
if ~isempty(mask)
	set(h,'AlphaData',alpha.*mask);
	contour(mask,[0.5 0.5]); %Emphasize the boundary
else
	set(h,'AlphaData',alpha);
end
hold off
