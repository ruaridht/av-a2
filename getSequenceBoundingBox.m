function [ left, up, right, down ] = getSequenceBoundingBox( images )

    imageSize = size(images{1});
    finalImage = zeros(imageSize(1),imageSize(2));
    
    n = size(images);
    
    for i = 1 : n(2)
        image = images{i};
        imageSize = size(image);
        
        for x = 1 : imageSize(1)
        for y = 1 : imageSize(2)
            if(image(x,y) ~= 0)
                finalImage(x,y) = 1;
            end
        end
        end
    end
    
    [ left, up, right, down ] = getBoundingBox(finalImage);

end

