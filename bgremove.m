function binimage = bgremove (partim, bgims)

    T = double(min(double(min(min(partim))+(max(max(partim))-min(min(partim)))/2))/255);

    %detect change in red, green and blue values. Makes WxHx3 image
    n = numel(bgims);
    for i = 1 : n
        
        bgim = bgims(i);
        bgim = cell2mat(bgim);
        
        [H,W] = size(partim);
        outim = zeros(H,W);
        for r = 1 : H
        for c = 1 : W
          if abs(double(bgim(r,c)) - double(partim(r,c))) > T*50
              outim(r,c) = double(1);
          end
        end
        end
    end


    %combine red, green and blue elements detected to make one black and white image
    [H,W] = size(outim);
    outim2 = zeros(H,W/3);
    for r = 1 : H
    for c = 1 : W/3;
      outim2(r,c) = double(outim(r,c)+outim(r,c+W/3)+outim(r,c+W*2/3));
    end
    end

    binimage = outim2;

