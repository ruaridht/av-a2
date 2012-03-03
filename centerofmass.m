function [rbar cbar] = centerofmass(im)
    [H,W] = size(im);
    
    % r: the sum of the height
    % c: the sum of the width
    r = 0;
    c = 0;
    
    area = 0;
    
    % Calculate
    for x = 1 : W
        for y = 1 : H
           if (im(y,x) > 0) 
             r = r + y;
             c = c + x;
             area = area + im(y,x);
           end
        end
    end

    % Get the averages (dividing by the area) and return them.
    rbar = round(r/area);
    cbar = round(c/area);
    com = [rbar cbar];
end