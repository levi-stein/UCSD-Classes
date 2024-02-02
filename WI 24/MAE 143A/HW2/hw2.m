clc; clear all; close all;
%% Problem 1 of 2023 Midterm Plotting
t = 1:0.1:50;
y = @(t) (-1/3)*exp(-1*t) + (5/6)*exp(-4*t) + (-1/2);
plot(t,y(t),'-b');

%% Problem 2 of 2023 Midterm
a = [1 2 2];                            % coeff of bottom poly
[p] = RR_roots(a);                      % poles of T(s)
d1 = (-3*p(1)-2)/((p(1)-p(2))*p(1));    % heaviside coverup PFE
d2 = (-3*p(2)-2)/((p(2)-p(1))*p(2));
d0 = (-3*0-2)/((0-p(1))*(0-p(2)));

y = @(t) d1*exp(p(1)*t) + d2*exp(p(2)*t) + d0; % define y(t)
t = 1:0.1:50;
figure;
plot(t,y(t),'-b');

%% Problem 3 of 2023 Midterm Plotting

y = @(t) (-1/5)*exp(-5*t) + (1/5);
t = 1:0.1:50;
figure;
plot(t,y(t),'-b');