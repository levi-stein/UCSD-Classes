function ytarget = clamped_cubic_spline(xi, yi, sprime_x1, sprime_xn, xtarget)
% CLAMPED_CUBIC_SPLINE: interpolates the knots {xi,yi} to obtain a value for
% ytarget at a given xtarget using cubic splines with clamped end-point
% conditions. The first derivative at the first knot sprime_x1 and that
% at the last knots sprime_xn are used for the end-point conditions.
% Call format: ytarget = natural_cubic_spline(xi, yi, xtarget)

%% Error check
n = length(xi);  % number of knots
if length(yi) ~= n
    error('Error: xi and yi have different dimension!');
end

if any(diff(xi) <= 0) 
    error('Error: knots are not sorted in ascending order for xi!');
end
    
%% Construct matrix M and rhs
M = zeros(n);
rhs = zeros(n,1);
hi = diff(xi);
for i = 2:n-1
    M(i,i-1) = hi(i-1);          
    M(i,i) = 2 * ( hi(i-1)+hi(i) ); 
    M(i,i+1) = hi(i);
    rhs(i) = 3 *( (yi(i+1)-yi(i))/(xi(i+1)-xi(i)) ...
                 -(yi(i)-yi(i-1))/(xi(i)-xi(i-1)) );
end

%% Enforce end conditions for clamped cubic spline:
% first knot
M(1,1) = 2*hi(1);
M(1,2) = hi(1);
rhs(1) = 3*((yi(2)-yi(1))/(xi(2)-xi(1)) - sprime_x1);

% last knot
M(n,n) = -2*hi(n-1);
M(n,n-1) = -hi(n-1);
rhs(n) = 3*((yi(n)-yi(n-1))/(xi(n)-xi(n-1)) - sprime_xn);

%% Solve linear system to get coefficients: c, a, d, b
c = M\rhs;
for i = 1:n-1
    a(i) = yi(i);
    d(i) = (c(i+1)-c(i))/ 3 / hi(i);
    b(i) = (yi(i+1)-yi(i))/hi(i) - hi(i)/ 3 * (2*c(i)+ c(i+1));
end

%% Construct splines
for i = 1:n-1
    S{i} = @(x) a(i) + b(i)*(x-xi(i)) ...
                     + c(i)*(x-xi(i)).^2 + d(i)*(x-xi(i)).^3;
end

%% Interpolation to get ytarget
for i = 1:n-1
    if xtarget >= xi(i) && xtarget <= xi(i+1)
        ytarget = S{i}(xtarget);
        break;
    end
end
end % function clamped_cubic_spline


