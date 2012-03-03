function area = getMHIArea( im )
  [H,W] = size(im);
  area = 0;

  for x = 1 : W
      for y = 1 : H
         if (im(y,x) > 0)
           area = area + im(y,x);
         end
      end
  end
  
end

