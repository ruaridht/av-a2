% Build and draw our scatter plots
function scattman( fname )
% Draw a scatter plot for the training data
  all_moms = importdata(fname);
  
  x_plot = zeros(1,24);
  y_plot = zeros(1,24);
  colour = zeros(24,3);
  area = [];
  
  num = 24;
  
  for i = 1 : num
    x_plot(i) = all_moms(i,1);
    y_plot(i) = all_moms(i,4);
  end
  
  % black
  for i = 1 : 8
    colour(i,1) = 0;%[1 1 0];
    colour(i,2) = 0;
    colour(i,3) = 0;
  end
  
  % magenta
  for i = 9 : 16
    colour(i,1) = 1;%[1 0 1];
    colour(i,2) = 0;
    colour(i,3) = 1;
  end
  
  % cyan
  for i = 17 : 24
    colour(i,1) = 0;%[0 1 1];
    colour(i,2) = 1;
    colour(i,3) = 1;
  end
  
%   I'm the scatman
%   Ski bi di bi di do bap do bap 
%   Do ba do bap
  scatter(x_plot,y_plot,area,colour);
%   Repeat after me
%   It's a scoobie oobie doobie scoobie doobie melody
%   Sing along with me
%   It's a scoobie oobie doobie scoobie doobie melody
  
end

