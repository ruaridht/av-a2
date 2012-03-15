% gets a given complex central moment value
function muv = complexmoment(Image,u,v)

  [rbar cbar] = centerofmass(Image);
  [H,W] = size(Image);
  
  c_uv_sum = 0;
  
  for r = 1 : H
    for c = 1 : W
      c1 = complex(r - rbar, c - cbar);
      c2 = complex(r - rbar, cbar - c);
      to_sum = c1^u * c2^v * Image(r,c);
      c_uv_sum = c_uv_sum + to_sum;
    end
  end
  
  muv = c_uv_sum;
end