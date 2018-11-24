%directly adjacent pixel classification into C-means clustering algorithm
%function [IX2]=fcm_s(IM);
%IM is the input source image
%IX2is the result of classification
IM=imread('Picture_13.jpg');
figure(1)
subplot(2,2,1),imshow(uint8(IM)),title('source image');

IM=IM(:,:,1);
subplot(2,2,2),imshow(uint8(IM)),title('gray image');
[maxX,maxY]=size(IM);%size of the image
%IM = imnoise(IM,'salt & pepper',0.02);
IM=imnoise(IM,'gaussian',0,0.002);
IM=double(IM);

IMM=cat(3,IM,IM,IM);
%initialize the cluster center£¨3class£©
cc1=20;
cc2=130;
cc3=240;
ttFcm=0;%the number of clustering, at most 5 times
while(ttFcm<15)
    ttFcm=ttFcm+1;
    c1=cc1*ones(maxX,maxY);
    c2=cc2*ones(maxX,maxY);
    c3=cc3*ones(maxX,maxY);
    c=cat(3,c1,c2,c3);
    
    a=[1,1,1;1,0,1;1,1,1];
    
  %calculation of membership u 
        distance=IMM-c;
        distance=distance.*distance ;%3 dimensiional matrix
    
        distance1=distance(:,:,1)+0.125*filter2(a,distance(:,:,1));
        distance2=distance(:,:,2)+0.125*filter2(a,distance(:,:,2));
        distance3=distance(:,:,3)+0.125*filter2(a,distance(:,:,3));
        
        u1=distance1./(distance1+distance2+distance3);
        u2=distance2./(distance1+distance2+distance3);
        u3=distance3./(distance1+distance2+distance3);
        
 %caclulate cluster center z
        im=0.225*filter2(a,IM)+IM;
        %im=256/max(max(im))*im;
        subplot(2,2,3),imshow(uint8(im)),title('transfrom image');
        ccc1=sum(sum(u1.*u1.*im))/(2.8*sum(sum(u1.*u1)));
        ccc2=sum(sum(u2.*u2.*im))/(2.8*sum(sum(u2.*u2)));
       ccc3=sum(sum(u3.*u3.*im))/(2.8*sum(sum(u3.*u3)));
       
     
       tmpMatrix=[abs(cc1-ccc1)/cc1,abs(cc2-ccc2)/cc2,abs(cc3-ccc3)/cc3];
    
        pp=cat(3,u1,u2,u3);
        for i=1:maxX;
            for j=1:maxY;
                if max(pp(i,j,:))==u1(i,j)
                    IX2(i,j)=1;
                elseif max(pp(i,j,:))==u2(i,j)
                    IX2(i,j)=2;
                else
                    IX2(i,j)=3;
                end
            end
        end
     %end of sentence
        if max(tmpMatrix)<0.00001
            break;
        else
            cc1=ccc1;
            cc2=ccc2;
            cc3=ccc3;
        end
        
      for i=1:maxX;
            for j=1:maxY;
                if IX2(i,j)==3
                    IMMM(i,j)=0;
                elseif IX2(i,j)==2
                    IMMM(i,j)=0;
                else
                    IMMM(i,j)=255;
                end
            end
      end
        
        
 
end

    for i=1:maxX;
            for j=1:maxY;
                if IX2(i,j)==3
                    IMMM(i,j)=0;
                elseif IX2(i,j)==2
                    IMMM(i,j)=0;
                else
                    IMMM(i,j)=255;
                end
            end
    end
        
%show the result of classifcation
IMMM=uint8(IMMM);
subplot(2,2,4),imshow(IMMM),title('FCM_S cluster result');
%end