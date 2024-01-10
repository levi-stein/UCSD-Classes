clear all;
close all;
clc;
format long;
name = 'Levi Stein';
id = 'A16791467';
hw_num = 1;
%% Problem 1:
x = [-1:0.02:1];
fx = cos(x);
t0 = my_cos(x,0);
t1 = my_cos(x,1);
t2 = my_cos(x,2);
t3 = my_cos(x,3);

figure(1);
subplot(2,1,1);
plot(x,t0,'--m',x,t1,'--r',x,t2,'--b',x,t3,'--g',x,fx,'--k','LineWidth',1);
xlabel('x'); ylabel('P_n(x) and cos(x)');
axis tight; box on; grid on;
title('Taylor Polynomials to Degree 3 for f(x) = cos(x)');
legend('n = 0','n = 1','n = 2','n = 3','f(x) = cos(x)','Location','northwest');

subplot(2,1,2);
semilogy(x,abs(fx-t0),'-m',x,abs(fx-t1),'-r',x,abs(fx-t2),'-b',x,abs(fx-t3),'-g','LineWidth',1);
xlabel('x'); ylabel('absolute error');
axis tight; box on; grid on;
title('Absolute Errors Associated with Taylor Polynomials');

p1 = 'See figure 1';
%% Problem 2:
% (a,b) Find the root of f (x) = e−x2 sin(5x) with ε = 10−4 and [a, b] = [0.51, 2]. 
% Put the root in p2a and the corresponding number of steps in p2b.
f = @(x) exp(-x.^2).*sin(5*x);
[p2a,p2b] = my_bisection(f,0.51,2,0.0001);
% (c,d) Repeat parts (a, b) with the new interval [a, b] = [0.52, 2]. 
% Put the root in p2c and the corresponding number of steps in p2d.
[p2c,p2d] = my_bisection(f,0.52,2,0.0001);
% (e,f) Find the root of f (x) = sin(x + 10−10) with ε = 10−4 and [a, b] = [−2.5π, 2.5π]. 
% Put the root in p2e and the corresponding number of steps in p2f.
g = @(x) sin(x + 10^(-10));
[p2e,p2f] = my_bisection(g,-2.5*pi,2.5*pi,0.0001);
