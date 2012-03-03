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
  
%   [r,c] = find(Image>0); % get (r,c) of region's pixels
%   
%   n = length(r);
%   momlist = zeros(n,1);
%   for i = 1 : n
%     c1 = complex(r(i) - rbar,c(i) - cbar);
%     c2 = complex(r(i) - rbar,cbar - c(i));
%     momlist(i) = (c1^u * c2^v) * Image(r(i),c(i));
%   end
%   muv = sum(momlist);
end