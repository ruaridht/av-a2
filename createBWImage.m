function bwim = createBWImage( im )
  [H,W] = size(im);
    
  bwim = zeros(H,W);

  for x = 1 : W
      for y = 1 : H
         if (im(y,x) > 0) 
           bwim(y,x) = 1;
         end
      end
  end

end

