% This is a support function that calls everything we need.
function ret = main()
  bg = imread('background1.jpg');
  bg2 = imread('background2.jpg');
  bgs = { bg bg2 };
  
  % define all the individual sets (no longer training).
  train_sets_paper = { '1-1/' '1-2/' '1-3/' '2-2/' '2-5/' '3-7/' '3-8/' '3-9/' }; % test using '3-9/' };
  train_sets_scissors = { '1-7/' '1-8/' '1-9/' '2-1/' '2-4/' '3-4/' '3-5/' '3-6/' }; % test using '3-6/' };
  train_sets_rock = { '1-4/' '1-5/' '1-6/' '2-3/' '2-6/' '3-1/' '3-2/' '3-3/' }; % test using '3-3/' };
  
  % define the lists to store the moment invariant descriptors
  p_moms = [];
  s_moms = [];
  r_moms = [];
  
  % define what we need for the Naïve Bayes classifier
  naive_training = [];
  naive_classes = {};
  cc = 1;
  
  
  sizey = size(train_sets_paper);
  tnum = sizey(2); % 7
  
  % these are the proceedures for generating the moment invariant
  % descriptors for all the training images.
  % what we have done is run this once for all image sets and stored the
  % outcome in a file, saving us calculating this every time we run.
%   % for paper
%   for i = 1 : tnum
%     im_dir = strcat('av212data/train/', train_sets_paper{i});
%     images = removeBackgroundFromImageSet(bgs, im_dir);
% 
%     [l u r d] = getSequenceBoundingBox(images);
%     mhi = createMHI(images, [l u r d]);
%     mhi_moms = getMomentInvDesc(mhi);
% 
%     p_moms = [p_moms ; mhi_moms];
%     naive_training = [naive_training ; mhi_moms];
%     naive_classes{cc} = 'paper';
%     cc = cc + 1;
%     pp = i % this gives us an idea of how long things are taking
%   end
%   
%   pp = 'Done with paper'
%   
%   % for scissors
%   for i = 1 : tnum
%     im_dir = strcat('av212data/train/', train_sets_scissors{i});
%     images = removeBackgroundFromImageSet(bgs, im_dir);
% 
%     [l u r d] = getSequenceBoundingBox(images);
%     mhi = createMHI(images, [l u r d]);
%     mhi_moms = getMomentInvDesc(mhi);
% 
%     s_moms = [s_moms ; mhi_moms];
%     naive_training = [naive_training ; mhi_moms];
%     naive_classes{cc} = 'scissors';
%     cc = cc + 1;
%     pp = i
%   end
%   
%   pp = 'Done with scissors'
%   
%   % for rock
%   for i = 1 : tnum
%     im_dir = strcat('av212data/train/', train_sets_rock{i});
%     images = removeBackgroundFromImageSet(bgs, im_dir);
% 
%     [l u r d] = getSequenceBoundingBox(images);
%     mhi = createMHI(images, [l u r d]);
%     mhi_moms = getMomentInvDesc(mhi);
% 
%     r_moms = [r_moms ; mhi_moms];
%     naive_training = [naive_training ; mhi_moms];
%     naive_classes{cc} = 'rock';
%     cc = cc + 1;
%     pp = i
%   end
%   
%   pp = 'Done with rock'
  
  % load the pre-calculated moment invariant descriptors
  all_moms = importdata('naive_training.txt');
  p_test = [];
  s_test = [];
  r_test = [];
  pt_num = 4;
  st_num = 2;
  rt_num = 2;
  
  % repopulate the moms and easily choose test mom
  for i = 1 : 8
    mom = [all_moms(i,1) all_moms(i,2) all_moms(i,3) all_moms(i,4) all_moms(i,5) all_moms(i,6) all_moms(i,7)];
    if (i==pt_num)
      p_test = mom;
    else
      naive_training = [naive_training ; mom];
    end
  end
  for i = 9 : 16
    mom = [all_moms(i,1) all_moms(i,2) all_moms(i,3) all_moms(i,4) all_moms(i,5) all_moms(i,6) all_moms(i,7)];
    if (i==(st_num+8))
      s_test = mom;
    else
      naive_training = [naive_training ; mom];
    end
  end
  for i = 17 : 24
    mom = [all_moms(i,1) all_moms(i,2) all_moms(i,3) all_moms(i,4) all_moms(i,5) all_moms(i,6) all_moms(i,7)];
    if (i==(rt_num+16))
      r_test = mom;
    else
      naive_training = [naive_training ; mom];
    end
  end
  
  % there are 7 of each class used to train the classifier
  for i=1 : 21
    if (i<=7)
      naive_classes{i} = 'paper';
    end
    if (i>7 && i<=14)
      naive_classes{i} = 'scissors';
    end
    if (i>14)
      naive_classes{i} = 'rock';
    end
  end
  
  pp = 'Starting bayes'
  
  nc = naive_classes';
  
  % only needed to do this once, or the image processing is changed.
  % save 'naive_training.txt' naive_training '-ASCII';
  
  % create a naive bayes classifier and fit our training data.
  nb = NaiveBayes.fit(naive_training, nc);
  
  % make predictions on our test data.
  pt = nb.predict(p_test)
  st = nb.predict(s_test)
  rt = nb.predict(r_test)
  
  % we return the Naïve Bayes classifier for test purposes.
  ret = nb;
  
end

