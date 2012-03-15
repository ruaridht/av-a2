function runtests(dname,fname)
  % Here we run the classifier for all data and record the data to a file.
  
  %dname ='results_firsthalf/';
  %fname = 'filename of training data';
  
  %For all paper train/test combinations
  for i = 1 : 8

    % For all scissors train/test combinations
    for j = 1 : 8

      % For all rock train/test combinations
      for k = 1 : 8

        [ ptr str rtr ] = maintest(i,j,k,fname);

        filename = strcat(dname,int2str(i), '_', int2str(j), '_', int2str(k), '.txt');
        fileID = fopen(filename,'w');
        fprintf(fileID,'%s\n', ptr{1});
        fprintf(fileID,'%s\n', str{1});
        fprintf(fileID,'%s\n', rtr{1});
        fclose(fileID);

      end
    end
  end
end