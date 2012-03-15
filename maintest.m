function [ ptr str rtr ]  = maintest( pt, st, rt, fname)
%This function performs all the same steps as main.m
% Though here there are additions to cover iterating through all training
% and perform all tests.
% The inputs:
% pt, st, rt
% are the test numbers to be used for pt_num, st_num and rt_num.
% The outputs are:
% ptr: paper_test_result
% str: scissors_test_result
% rtr: rock_test_result
  
  % define all the individual sets (no longer training).
  train_sets_paper = { '1-1/' '1-2/' '1-3/' '2-2/' '2-5/' '3-7/' '3-8/' '3-9/' };
  train_sets_scissors = { '1-7/' '1-8/' '1-9/' '2-1/' '2-4/' '3-4/' '3-5/' '3-6/' };
  train_sets_rock = { '1-4/' '1-5/' '1-6/' '2-3/' '2-6/' '3-1/' '3-2/' '3-3/' };
  
  % define what we need for the Naïve Bayes classifier
  naive_training = [];
  naive_classes = {};
  
  % fname = 'naive_training.txt';
  % load the pre-calculated moment invariant descriptors
  all_moms = importdata(fname);
  p_test = [];
  s_test = [];
  r_test = [];
  pt_num = pt;
  st_num = st;
  rt_num = rt;
  
  % repopulate the moms and easily choose test mom
%   for i = 1 : 8
%     mom = [all_moms(i,1) all_moms(i,2) all_moms(i,3) all_moms(i,4) all_moms(i,5) all_moms(i,6) all_moms(i,7)];
%     if (i==pt_num)
%       p_test = mom;
%     else
%       naive_training = [naive_training ; mom];
%     end
%   end
%   for i = 9 : 16
%     mom = [all_moms(i,1) all_moms(i,2) all_moms(i,3) all_moms(i,4) all_moms(i,5) all_moms(i,6) all_moms(i,7)];
%     if (i==(st_num+8))
%       s_test = mom;
%     else
%       naive_training = [naive_training ; mom];
%     end
%   end
%   for i = 17 : 24
%     mom = [all_moms(i,1) all_moms(i,2) all_moms(i,3) all_moms(i,4) all_moms(i,5) all_moms(i,6) all_moms(i,7)];
%     if (i==(rt_num+16))
%       r_test = mom;
%     else
%       naive_training = [naive_training ; mom];
%     end
%   end
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
  
  nc = naive_classes';
  
  % create a naive bayes classifier and fit our training data.
  nb = NaiveBayes.fit(naive_training, nc);
  
  % make predictions on our test data.
  pt = nb.predict(p_test);
  st = nb.predict(s_test);
  rt = nb.predict(r_test);
  
  % we return the Naïve Bayes classifier for test purposes.
  ptr = pt;
  str = st;
  rtr = rt;

end

