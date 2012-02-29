function images = removeBackgroundFromImageSet( bgImage, imageDir )

    imagefiles = dir(strcat(imageDir,'*.jpg'));  % collect all images in specified directory
    nfiles = length(imagefiles);    % number of files found
    images = {};     %init the image array
    
    for i = 1 : nfiles
       
       %get the image file
       currentfilename = imagefiles(i).name;
       filepath = strcat(imageDir,currentfilename);
       currentimage = imread(filepath);
       
       %remove bg
       currentimage = bgremove(currentimage,bgImage);
       
       %clean image
       currentimage = cleanup(currentimage,3,3,0);
       
       %store the image
       images{i} = currentimage;
    end

end
