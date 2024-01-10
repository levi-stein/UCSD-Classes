function f = colebrook(roughness_ratio, Re)
% COLEBROOK: solves for the root of the Cole-Brook equation using
% secant method. Inputs are roughness_ratio and Reynolds number Re. 
% Output is friction factor f from the root estimate.
% Call format: f = colebrook(roughness_ratio, Re)

%% Setup for secant method
n = 1;
max_iter = 26;
tolerance = 1e-5;

%% Setup for Cole-Brook equation and initial guesses
colebrook_eqn = @(x) 1/sqrt(x) + 2*log10((roughness_ratio/3.72) + (2.51/(sqrt(x)*Re)));
x0 = 0.02;      % initial guesses
x1 = 0.04;

%% Execute secant method
while (n <= max_iter) % && (eps >= tolerance) 
%     diff = -1*colebrook_eqn(x(n+1))*((x(n+1) - x(n))/(colebrook_eqn(x(n+1))-colebrook_eqn(x(n))));
%     x(n+2) = diff + x(n+1);
%     eps = abs(diff);
%     xn = x(n+2);
%     n = n + 1; 
f0 = colebrook_eqn(x0);
f1= colebrook_eqn(x1);
xn = x1 - f1*(x1-x0)/(f1-f0);
fxn = colebrook_eqn(xn);
    if abs(xn-x1) < tolerance
        f = xn;
        break;
    else
        n = n + 1;
        x0 = x1;
        x1 = xn;
    end
end

f = xn; % output friction factor

%% When secant is not converging, set xn to NaN
if n > max_iter
    xn = NaN;
    disp('Secant method does converge within the max number of iterations')
end

end % function colebrook