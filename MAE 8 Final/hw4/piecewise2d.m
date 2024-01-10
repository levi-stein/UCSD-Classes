function f = piecewise2d(x,y)
%PIECEWISE2D Gives a value for the function f based on four piecewise
%function restrictions and input value x and y. Output is a single element f
%Call format: f = piecewise2d(x,y)

if x >= 0 && y > 0
    f = 7*x+7*y;
elseif x < 0 && y >= 0
    f = -7*x+7*y;
elseif x <= 0 && y < 0
    f = -7*x-7*y;
elseif x > 0 && y <= 0
    f = 7*x-7*y;
else
    f = NaN;
end % if on line 6

end % function piecewise2d