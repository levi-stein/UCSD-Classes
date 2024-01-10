function [p] = my_cos(x,n)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

p = 0;
for k = 0:n
    p = p + (((-1)^k)/factorial(2*k))*x.^(2*k);
end

end