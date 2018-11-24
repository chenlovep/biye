function [ val_ ] = Thres( im )
im=double(im);
[row,col]=size(im);
s=0;
for i=1:row
    for j=1:col
        s=s+im(i,j);
    end
end
disp(s);
val_=s/(row*col);

while 1
    t1=0;t2=0;t1_count=0;t2_count=0;
    for i=1:row
        for j=1:col
            if im(i,j)<val_
                t1=t1+im(i,j);
                t1_count=t1_count+1;
            else
                t2=t2+im(i,j);
                t2_count=t2_count+1;
            end
        end
    end
    t1=t1/t1_count;t2=t2/t2_count;
    if abs((t1+t2)/2-val_)<1
    break
    else
        val_=(t1+t2)/2;
    end
end

