clear all;
close all;

epsilon = 10;

img = rgb2gray(imread('2.jpg'));
%img = imread('27.jpg');
figure;
imshow(img);
[row,col] = size(img);
template_size = 5;
Row = template_size - 1 + row;
Col = template_size - 1 + col;
Img_extension = zeros(Row,Col);
for i = (template_size + 1)/2:Row - (template_size - 1)/2
    for j = (template_size + 1)/2:Col - (template_size - 1)/2 
        Img_extension(i,j) = img(i - (template_size + 1)/2 + 1,j - (template_size + 1)/2 + 1);
    end
end

Img_extension = uint8(Img_extension);

Img_template = zeros(template_size, template_size);
d = zeros(row, col);
e = zeros(row, col);
s = zeros(row, col);
f = zeros(row, col);
for i = 1:row
    for j = 1:col
        Img_template = Img_extension(i:i+template_size - 1,j:j + template_size - 1);
        [d(i,j),e(i,j),s(i,j)] = FastBlanketLFD(Img_template, epsilon);
    end
end

figure;
imshow(d,[]);
figure;
imshow(e,[]);
figure;
imshow(s,[]);
figure;
imshow(f,[]);
