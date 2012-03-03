function [ finalImage ] = createMHI( images , cropBounds )

    imageSize = size(images{1});
    finalImage = zeros(imageSize(1),imageSize(2));
    
    n = size(images);
    colour = 1/n(2);

    for i = 1 : n(2)   
        image = images{i};
        imageSize = size(image);
        
        for y = 1 : imageSize(1)
        for x = 1 : imageSize(2)
            if(image(y,x) ~= 0)
                finalImage(y,x) = (image(y,x) * (colour*i));
            end
        end
        end
    end
    
    finalImage = imcrop( finalImage, cropBounds );

end

