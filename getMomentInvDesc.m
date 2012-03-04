% We have altered getproperties.m to work for our MHI images.
function vec = getMomentInvDesc( Image )

  [H,W] = size(Image);
  area = getMHIArea(Image);
  bwim = createBWImage(Image);
  perim = bwarea(bwperim(bwim,4));

  compactness = perim*perim/(4*pi*area);

  % rescale properties so all have size proportional
  % to image size
  % vec = [4*sqrt(area), perim, H*compactness];

  % Without rotation invariants
  % get scale-normalized complex central moments
  c11 = complexmoment(Image,1,1) / (area^2);
  c20 = complexmoment(Image,2,0) / (area^2);
  c30 = complexmoment(Image,3,0) / (area^2.5);
  c21 = complexmoment(Image,2,1) / (area^2.5);
  c12 = complexmoment(Image,1,2) / (area^2.5);
  %c=[c11,c20,c30,c21,c12]
  
  % with rotation invariants
  % get invariants, scaled to [-1,1] range
  ci1 = real(c11);
  ci2 = real(1000*c21*c12);
  tmp = c20*c12*c12;
  ci3 = 10000*real(tmp);
  ci4 = 10000*imag(tmp);
  tmp = c30*c12*c12*c12;
  ci5 = 1000000*real(tmp);
  ci6 = 1000000*imag(tmp);

  vec = [compactness,ci1,ci2,ci3,ci4,ci5,ci6];
  
end

