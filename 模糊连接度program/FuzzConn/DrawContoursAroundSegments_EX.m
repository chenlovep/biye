function img_ContoursEX = DrawContoursAroundSegments_EX(img, klabels)

dx = [-1, -1, 0, 1, 1, 1, 0, -1];
dy = [0, -1, -1, -1, 0, 1, 1, 1];
[m_height, m_width, m_channel] = size(img);
img_ContoursEX = double(img);

mainindex = 0;
cind = 0;
M = max(max(klabels));
disp(size(img));
random_color = zeros(M,3);
%for i=1:M
random_color(:, 1) = [50,100,150,200,250,20,60,120,140,160,180,220,240,70,130,170];
random_color(:, 2) = [50,100,150,200,250,20,60,120,140,160,180,220,240,70,130,170];
random_color(:, 3) = [50,100,150,200,250,20,60,120,140,160,180,220,240,70,130,170];
%end
for j = 1: m_height
    for k = 1: m_width
        np = 0;
        for i = 1: 8
            x = k+dx(1, i);
            y = j+dy(1, i);
            if (x>0&&x<=m_width&&y>0&&y<m_height)
               if (klabels(j, k)~=klabels(y, x))
                   np = np+1;
               end
            end
        end
        
        if (np>2)
            img_ContoursEX(j, k, 1) = 255;
            img_ContoursEX(j, k, 2) = 255;
            img_ContoursEX(j, k, 3) = 255;
        else
            img_ContoursEX(j, k, 1) = random_color(klabels(j, k), 1);
            img_ContoursEX(j, k, 2) = random_color(klabels(j, k), 2);
            img_ContoursEX(j, k, 3) = random_color(klabels(j, k), 3);
           
        end
    end
end