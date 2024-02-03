clc; clear all; close all;
%% Problem 1 of 2023 Midterm Plotting
t = 0:0.1:50;
y = @(t) (-1/3)*exp(-1*t) + (5/6)*exp(-4*t) + (-1/2);
plot(t,y(t),'-b');

%% Problem 2 of 2023 Midterm
a = [1 2 2];                            % coeff of bottom poly
[p] = RR_roots(a);                      % poles of T(s)
d1 = (-3*p(1)-2)/((p(1)-p(2))*p(1));    % heaviside coverup PFE
d2 = (-3*p(2)-2)/((p(2)-p(1))*p(2));
d0 = (-3*0-2)/((0-p(1))*(0-p(2)));

y = @(t) d1*exp(p(1)*t) + d2*exp(p(2)*t) + d0; % define y(t)
t = 0:0.1:50;
figure;
plot(t,y(t),'-b');

%% Problem 3 of 2023 Midterm Plotting

y = @(t) (-1/5)*exp(-5*t) + (1/5);
t = 0:0.1:50;
figure;
plot(t,y(t),'-b');

%% Problem 1 of 2013 Midterm

clear; syms L1 L2 L3 L4 x y u
eqn1= L1*y+L2*x==u;
eqn2= L3*x+L4*y==-u;
sol=solve(eqn1,eqn2,x,y); G=sol.y/u;

syms s  m1 m2 g I1 I2 k
G=subs(sol.y/u,{L1,L2,L3,L4},{I1*(s^2)-(m1*g)+k, -k, I2*(s^2)-m2*g+k, -k});
[numG,denG] = numden(G);      % this extracts out the num and den of G
numG=coeffs(numG,s);          % this extracts the powers of s in the num and den
denG=coeffs(denG,s);
numG=simplify(numG/denG(end)); % this makes the den monic
denG=simplify(denG/denG(end));

numG=numG(end:-1:1);   % this reverses the order of the vector of coefficients.
denG=denG(end:-1:1);

a = [1 -129/8 45/4]; % calculating coeff based on denG
[p] = RR_roots(a); % poles of our transfer function
d1 = ((1/8)*p(1)+(-15/4))/(p(1)-p(2)); %coeff from PFE
d2 = ((1/8)*p(2)+(-15/4))/(p(2)-p(1));

y = @(t) d1*exp(p(1)*t) + d2*(p(2)*t); % plotting inverse laplace transform
t = 0:0.1:10;
figure;
plot(t,y(t),'-b');

