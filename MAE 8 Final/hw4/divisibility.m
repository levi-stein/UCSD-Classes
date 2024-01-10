function div = divisibility(a)
% DIVISIBILITY Checks whether a number is divisible by 3,5,7,11,13 and 17.
% Returns a six element logical vector div
% Call formtat: div = divisibility(a)
div(1:6) = false; % setting div to six element logical vector of 0 (preallocating)
if rem(a,3) == 0
    div(1) = true;
end % if on line 6
if rem(a,5) == 0
    div(2) = true;
end % if on line 9
if rem(a,7) == 0
    div(3) = true;
end % if on line 12
if rem(a,11) == 0
    div(4) = true;
end % if on line 15
if rem(a,13) == 0
    div(5) = true;
end % if on line 18
if rem(a,17) == 0
    div(6) = true;
end % if on line 21

end % for function