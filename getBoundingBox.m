function [ left, up, right, down ] = getBoundingBox( image )

    imageSize = size(image);
    
    left = imageSize(1)+1;
    up = imageSize(2)+1;
    right = 0;
    down = 0;
    
    for y = 1 : imageSize(1)
    for x = 1 : imageSize(2)
        if(image(y,x) == 1)
           if(x < left)
              left = x; 
           end
           if(y < up)
              up = y; 
           end
           if(x > right)
              right = x; 
           end
           if(y > down)
              down = y; 
           end
        end
    end
    end

end

