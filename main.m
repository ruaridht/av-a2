% This is a support function that calls everything we need.
function [res mhi] = main(fname)
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
  
  sizey = size(train_sets_paper);
  tnum = sizey(2); % 7
  
  % these are the proceedures for generating the moment invariant
  % descriptors for all the training images.
  % what we have done is run this once for all image sets and stored the
  % outcome in a file, saving us calculating this every time we run.
  % for paper
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
%     pp = i
%   end
  
  %pp = 'Done with rock'

%   im_dir = strcat('av212test/t1/', train_sets_paper{i});
  images = removeBackgroundFromImageSet(bgs, 'av212test/t2/');

  [l u r d] = getSequenceBoundingBox(images);
  mhi = createMHI(images, [l u r d]);
  mhi_moms = getMomentInvDesc(mhi);
  
  pp = 'Done with data'
  
  naive_training = [];
  naive_classes = {};
  
  % fname = 'naive_training.txt';
  % load the pre-calculated moment invariant descriptors
  all_moms = importdata(fname);
  
  for i = 1 : 24
    mom = [all_moms(i,1) all_moms(i,2) all_moms(i,3) all_moms(i,4) all_moms(i,5) all_moms(i,6) all_moms(i,7)];
    
    naive_training = [naive_training ; mom];
  end
  
  % there are 7 of each class used to train the classifier
  for i=1 : 24
    if (i<=8)
      naive_classes{i} = 'paper';
    end
    if (i>8 && i<=16)
      naive_classes{i} = 'scissors';
    end
    if (i>16)
      naive_classes{i} = 'rock';
    end
  end
  
  % fname = naive_training.firsthalf.txt
  % only needed to do this once, or the image processing is changed.
  %save 'naive_training.midthird.txt' naive_training '-ASCII';
  
  nc = naive_classes';
  
  % create a naive bayes classifier and fit our training data.
  nb = NaiveBayes.fit(naive_training, nc);
  
  % make predictions on our test data.
  res = nb.predict(mhi_moms)
  
  pp = fname;
  
end

