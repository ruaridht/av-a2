function ret = main()
  bg = imread('background1.jpg');
  bg2 = imread('background2.jpg');
  bgs = { bg bg2 };
  
  train_sets_paper = { '1-1/' '1-2/' '1-3/' '2-2/' '2-5/' '3-7/' '3-8/' }; % test using '3-9/' };
  train_sets_scissors = { '1-7/' '1-8/' '1-9/' '2-1/' '2-4/' '3-4/' '3-5/' }; % test using '3-6/' };
  train_sets_rock = { '1-4/' '1-5/' '1-6/' '2-3/' '2-6/' '3-1/' '3-2/' }; % test using '3-3/' };
  
  p_moms = [];
  s_moms = [];
  r_moms = [];
  
  naive_training = [];
  naive_classes = {};
  cc = 1;
  
  sizey = size(train_sets_paper);
  tnum = sizey(2); % 7
  
  % for paper
  for i = 1 : tnum
    im_dir = strcat('av212data/train/', train_sets_paper{i});
    images = removeBackgroundFromImageSet(bgs, im_dir);

    [l u r d] = getSequenceBoundingBox(images);
    mhi = createMHI(images, [l u r d]);
    mhi_moms = getMomentInvDesc(mhi);

    p_moms = [p_moms ; mhi_moms];
    naive_training = [naive_training ; mhi_moms];
    naive_classes{cc} = 'paper';
    cc = cc + 1;
    pp = i % this gives us an idea of how long things are taking
  end
  
  pp = 'Done with paper'
  
  % for scissors
  for i = 1 : tnum
    im_dir = strcat('av212data/train/', train_sets_scissors{i});
    images = removeBackgroundFromImageSet(bgs, im_dir);

    [l u r d] = getSequenceBoundingBox(images);
    mhi = createMHI(images, [l u r d]);
    mhi_moms = getMomentInvDesc(mhi);

    s_moms = [s_moms ; mhi_moms];
    naive_training = [naive_training ; mhi_moms];
    naive_classes{cc} = 'scissors';
    cc = cc + 1;
    pp = i
  end
  
  pp = 'Done with scissors'
  
  % for rock
  for i = 1 : tnum
    im_dir = strcat('av212data/train/', train_sets_rock{i});
    images = removeBackgroundFromImageSet(bgs, im_dir);

    [l u r d] = getSequenceBoundingBox(images);
    mhi = createMHI(images, [l u r d]);
    mhi_moms = getMomentInvDesc(mhi);

    r_moms = [r_moms ; mhi_moms];
    naive_training = [naive_training ; mhi_moms];
    naive_classes{cc} = 'rock';
    cc = cc + 1;
    pp = i
  end
  
  pp = 'Done with rock'
  pp = 'Starting bayes'
  
  nc = naive_classes';
  
  % create a naive bayes classifier and fit our trainig data.
  nb = NaiveBayes.fit(naive_training, nc);

  %mvec = createMeanVector(paper_moms);
  
  ret = nb;
  
end
