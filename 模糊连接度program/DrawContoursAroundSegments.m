function img_Contours = DrawContoursAroundSegments(img, klabels)
%params:
%input:
%-----img:原图像
%-----klabels：标签图像
%output:
%-----img_Contours:图像边界
dx = [-1, -1, 0, 1, 1, 1, 0, -1];
dy = [0, -1, -1, -1, 0, 1, 1, 1];
[m_height, m_width, m_channel] = size(img);
img_Contours = uint8(zeros(m_height, m_width));

mainindex = 0;
cind = 0;
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
        %当像素的邻域内有3个或以上像素标签与其不一致时，将该像素归属于边界
        if (np>2)
            img_Contours(j, k) = 255;
        end
    end
end

            