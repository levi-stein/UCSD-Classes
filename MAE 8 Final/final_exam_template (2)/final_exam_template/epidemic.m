function [T,S,I,R] = epidemic(a,r)
%EPIDEMIC Takes input values a = infection rate and r = recovery rate and
%returns four vectors T = time, S = number of suceptible people, I = number
%of infected people, and R = number of recovered people. 
%Call Format: [T,S,I,R] = epidemic(a,r)

n = 1;
dt = 0.01;
T(n) = 0;
S(n) = 10^7;
I(n) = 2;
R(n) = 0;

while true
    S(n+1) = S(n) - a*S(n)*I(n)*dt;
    I(n+1) = I(n) + (a*S(n)*I(n) - r*I(n))*dt;
    R(n+1) = R(n) + r*I(n)*dt;
    T(n+1) = T(n) + dt;
    if I(n+1) < I(n)
        break
    end
     n = n + 1;
end





end