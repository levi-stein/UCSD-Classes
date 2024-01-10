function  y = lagrange_interp(xi, yi, x)
% LAGRANGE_INTERP: use Lagrange polynomials to interpolate value of y at 
% input x using the available data at nodes (xi,yi).
% Call format: y = lagrange_interp(xi, yi, x)

%% Preliminary check:
if x < min(xi) || x > max(xi)  % check bound
    disp('Error: Function does not perform extrapolation.');
    y = NaN;
    return;
elseif any(diff(sort(xi)) == 0) %Check for distinct nodes
    disp('Error: Nodes are not distinct.'); 
    y = NaN;
    return;
end

%% Lagrange interpolation: 
y = 0;
L = ones(length(xi),1);
for i = 1:length(xi)
%     product = (x-xi(
    for j = 1:length(xi)
        if i ~= j
            L(i,:) = L(i,:).*(x-xi(j))/(xi(i)-xi(j));
        end
    end
%     y = y + yi(i)*L(i,:);
end
for i = 1:length(xi)
    y = y + yi(i)*L(i,:);
end

end % function lagrange_interp