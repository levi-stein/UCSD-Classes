clear all;
close all;
clc;
format long;
name = 'Levi Stein';
id = 'A16791467';
hw_num = 4;
%% Problem 1:
% (a)  Set p1a = 'See figure 1'. Remember to label the axes with correct units and give
% the figure a title and a legend.

% Construct Matrix M and rhs:
E = 80*10^9; I = 900*(10^-8); w = 15*10^3; L = 5;
x = linspace(0,5,101); 
h = diff(x(1:2));
M = zeros(101);
n = size(M,1);
diag = linspace(-2,-2,101);
M(1:(n+1):end) = diag;
subdiag = linspace(1,1,100);
M(2:(n+1):end) = subdiag;
M(end,(end-1)) = 0;
superdiag = subdiag;
M((n+1):(n+1):end) = superdiag;
M(1,2) = 0;
for i = 1:101
    rhs(i) = ((w*L*h^2)/(2*E*I))*(x(i) - (x(i)^2)/L);
end

% Apply BC:
M(1) = 1;
rhs(1) = 0;
M(end) = 1;
rhs(end) = 0;

% Solve for y:

y = M\rhs';

% Plot:
y_exact = (w/(24*E*I))*(-x.^4 + 2*L*x.^3 - (L^3)*x);

figure; hold on;
plot(x,y,'ro','MarkerFaceColor','r');
plot(x,y_exact,'-k','LineWidth',3);
xlabel('Length of Beam (m)'); ylabel('Deflection of Beam (m)');
title('Approximation Deflection of a Beam');
legend('2nd Order Central Difference Approximation','Exact Solution');
hold off;
p1a = 'See figure 1';

% (b & c) What is the maximum error due to the finite-difference method and at what x
% location does the error occur? Put the answers in p1b and p1c, respectively.

for i = 1:n
    abs_error(i) = abs(y_exact(i) - y(i));
end

[p1b,ind] = max(abs_error);
p1c = x(ind);
%% Problem 2

load('f.mat');
hx = x(2) - x(1);
hy = y(2) - y(1);
xn = length(x);
yn = length(y);

% (a) Use improved trapezoid method. Integrate in x first, then in y and store the answer in p2a.

for i = 1:yn
    xiTh(i) = sum(f(2:end-1,i));
end

for i = 1:yn
    Thc_x(i) = hx*((f(1,i)+f(end,i))/2 + xiTh(i)) - (hx/24)*(3*f(1,i) - 4*f(2,i) + f(3,i) + f(end-2,i) - 4*f(end-1,i) + 3*f(end,i));
end

p2a = hy*((Thc_x(1)+Thc_x(end))/2 + sum(Thc_x(2:end-1))) - (hy/24)*(3*Thc_x(1) - 4*Thc_x(2) + Thc_x(3) + Thc_x(end-2) - 4*Thc_x(end-1) + 3*Thc_x(end));

% (b) Repeat the integration, but in y first then in x, and store the answer in p2b.

for i = 1:xn
    yiTh(i) = sum(f(i,2:end-1));
end

for i = 1:xn
    Thc_y(i) = hy*((f(i,1)+f(i,end))/2 + yiTh(i)) - (hy/24)*(3*f(i,1) - 4*f(i,2) + f(i,3) + f(i,end-2) - 4*f(i,end-1) + 3*f(i,end));
end

p2b = hx*((Thc_y(1)+Thc_y(end))/2 + sum(Thc_y(2:end-1))) - (hx/24)*(3*Thc_y(1) - 4*Thc_y(2) + Thc_y(3) + Thc_y(end-2) - 4*Thc_y(end-1) + 3*Thc_y(end));

% (c) Use Simpson’s rules. Integrate in x first, then in y and store the answer in p2c

for i = 1:yn
    term2(i) = sum(f(2:3:end-2,i));
    term3(i) = sum(f(3:3:end-1,i));
    term4(i) = sum(f(4:3:end-3,i));
end

for i = 1:yn
    S3h_x(i) = (3*hx/8)*(f(1,i) + 3*term2(i) + 3*term3(i) + 2*term4(i) + f(end,i));
end

p2c = (hy/3)*(S3h_x(1) + 4*sum(S3h_x(2:2:end-1)) + 2*sum(S3h_x(3:2:end-2)) + S3h_x(end));

% (d) Repeat the integration, in y first then in x, and store the answer in p2d.

for i = 1:xn
    term2(i) = sum(f(i,2:2:end-1));
    term3(i) = sum(f(i,3:2:end-2));
end

for i = 1:xn
    S3h_y(i) = (hy/3)*(f(i,1) + 4*term2(i) + 2*term3(i) + f(i,end));
end

p2d = (3*hx/8)*(S3h_y(1) + 3*sum(S3h_y(2:3:end-2)) + 3*sum(S3h_y(3:3:end-1)) + 2*sum(S3h_y(4:3:end-3)) + S3h_y(end));



