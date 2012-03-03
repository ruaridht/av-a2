function images = removeBackgroundFromImageSet( bgImages, imageDir )

    imagefiles = dir(strcat(imageDir,'*.jpg'));  % collect all images in specified directory
    nfiles = length(imagefiles);    % number of files found
    images = {};     %init the image array
    
    for i = 1 : nfiles
       
       %get the image file
       currentfilename = imagefiles(i).name;
       filepath = strcat(imageDir,currentfilename);
       currentimage = imread(filepath);
       
       %remove bg
       currentimage = bgremove(currentimage,bgImages);
       
       %clean image
       currentimage = cleanup(currentimage,3,0,0);
       currentimage = bwareaopen(currentimage,700);
       
       %store the image
       images{i} = currentimage;
    end

end

