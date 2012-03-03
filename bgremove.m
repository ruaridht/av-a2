function binimage = bgremove (partim, bgims)

    T = double(min(double(min(min(partim))+(max(max(partim))-min(min(partim)))/2))/255);
    
    %detect change in red, green and blue values. Makes WxHx3 image
    outims = {};
    n = numel(bgims);
    [H,W] = size(partim);
    for i = 1 : n
        
        bgim = bgims(i);
        bgim = cell2mat(bgim);
        
        outim = zeros(H,W);
        for r = 1 : H
          for c = 1 : W
            if abs(double(bgim(r,c)) - double(partim(r,c))) > T*50
                outim(r,c) = 1;
            end
          end
        end
        
        outims{i} = outim;
    end
    
    % Here we are taking the logical AND of all images to find their
    % intersection.
    composite = ones(H,W);
    if (n > 1)
      for i = 1 : n
        im = outims{i};
        for r = 1 : H
          for c = 1 : W
            composite(r,c) = composite(r,c) && im(r,c);
          end
        end
      end
    else
      composite = outims{1};
    end

    %combine red, green and blue elements detected to make one black and white image
    [H,W] = size(composite);
    outim2 = zeros(H,W/3);
    for r = 1 : H
      for c = 1 : W/3;
        outim2(r,c) = double(composite(r,c)+composite(r,c+W/3)+composite(r,c+W*2/3));
      end
    end

    binimage = outim2;

