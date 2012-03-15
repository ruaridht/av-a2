function evaluate(dname)
  % Here we run the classifier for all data and record the data to a file.

  paper_count = 0;
  scissors_count = 0;
  rock_count = 0;
  
  %dname = 'results_firsthalf/';

  %For all paper train/test combinations
  for i = 1 : 8

    % For all scissors train/test combinations
    for j = 1 : 8

      % For all rock train/test combinations
      for k = 1 : 8

        filename = strcat(dname,int2str(i), '_', int2str(j), '_', int2str(k), '.txt');
        fileID = fopen(filename,'r');
        results = textscan(fileID, '%s', 3);

        ptr = results{1}{1};
        str = results{1}{2};
        rtr = results{1}{3};

        TF = strcmpi(ptr,'paper');
        paper_count = paper_count + TF;

        TF = strcmpi(str,'scissors');
        scissors_count = scissors_count + TF;

        TF = strcmpi(rtr,'rock');
        rock_count = rock_count + TF;

        fclose(fileID);

      end
    end
  end

  pap_percent = paper_count / 512 * 100
  sci_percent = scissors_count / 512 * 100
  roc_percent = rock_count / 512 * 100

  overall_percent = (paper_count + scissors_count + rock_count) / 1536 * 100
end