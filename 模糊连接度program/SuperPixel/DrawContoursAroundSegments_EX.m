function img_ContoursEX = DrawContoursAroundSegments_EX(img, klabels)

dx = [-1, -1, 0, 1, 1, 1, 0, -1];
dy = [0, -1, -1, -1, 0, 1, 1, 1];
[m_height, m_width, m_channel] = size(img);
img_ContoursEX = img;

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
        if (np>2)
            img_ContoursEX(j, k, 1) = 255;
            img_ContoursEX(j, k, 2) = 255;
            img_ContoursEX(j, k, 3) = 255;
        end
    end
end