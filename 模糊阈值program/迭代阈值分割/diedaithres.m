im=imread('26.png');
im=double(im);
[row,col]=size(im);
c1=80;c2=160;
count=0;


while 1
    a1=0;a2=0;a3=0;a1num=0;a2num=0;a3num=0;
    for i=1:row
        for j=1:col
            if im(i,j)<c1
                a1=a1+im(i,j);
                a1num=a1num+1;
            elseif and(im(i,j)<c2,im(i,j)>c1)
                a2=a2+im(i,j);
                a2num=a2num+1;
            else
                a3=a3+im(i,j);
                a3num=a3num+1;
            end
        end
    end
    a1=a1/a1num;a2=a2/a2num;a3=a3/a3num;
    c1_new=(a1+a2)/2;c2_new=(a2+a3)/2;
    if and(abs(c1_new-c1)<1,abs(c2_new-c2)<1)
        break
    end
    c1=c1_new;c2=c2_new;
    
end
img=im*0;img1=im*0;
for i=1:row
    for j=1:col
        if im(i,j)<c1
            img(i,j,1)=0;
            img(i,j,2)=0;
            img(i,j,3)=0;
            img1(i,j)=0;
        elseif and(im(i,j)<c2,im(i,j)>c1)
            img(i,j,:)=[255,0,0];
            img1(i,j)=1;
        else
            img(i,j,:)=[255,255,255];
            img1(i,j)=2;
        end
    end
end
disp(c1);
disp(c2);
figure;
title('µü´ú·Ö¸î');
imshow(img);