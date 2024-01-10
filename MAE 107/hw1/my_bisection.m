function [xn, n] = my_bisection(f, a, b, epsilon)
% MYBISECTION returns the approximated root of f(x) using bisection method.
% Inputs are an anonymous function f, initial bracket [a, b] and absolute
% error epsilon. Output xn is the approximate value of the root and 
% n denotes the number of bisection steps taken.
% Call format: [xn, n] = my_bisection(f, a, b, epsilon)


%% Check whether the initial interval [a, b] is suitable for bisection
if f(a)*f(b) > 0
    disp('Bisection method does not work with input [a,b]!');
    xn = NaN; n = NaN;
    return  % exit the function
elseif f(a) == 0
    xn = a; n = 0;
    return  % exit the function
elseif f(b) == 0
    xn = b; n = 0; 
    return  % exit the function
end

%% Define the number of interval refinement, n
n = fix((log10(b-a)-log10(epsilon))/log10(2))+1;
fa = f(a);
fb = f(b);

%% Execute bisection
for i = 1:n
    c = a + 0.5*(b-a);
    fc = f(c);
    if fa*fc < 0
        b = c;
        fb = fc;
    elseif fa*fc > 0
        a = c;
        fa = fc;
    else
        return
    end
end
xn = c;
end % function my_bisection