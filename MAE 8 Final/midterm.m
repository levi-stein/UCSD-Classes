clear all;
close all;
clc;
format long;
name = 'Levi Stein';
id = 'A16791467';
hw_num = 'midterm';
form = 'B';
%% Problem 1
denominator = 1:1:199;
numerator = sqrt(2:200);
series = numerator./denominator;
p1 = sum(series(:));
%% Problem 2
A = [-2 1 0 0; 1 -2 1 0;0 1 -2 1;0 0 1 -2]; b = [8 0 0 4]';
x = A\b;
p2 = x;
%% Problem 3
rng(int8(form)); matA = randi(50,10);
% (a)
p3a = sum(matA(1,:));
% (b)
tempmat = matA(1:2:7,:); tempmat(5,:) = matA(10,:); 
p3b = mean(tempmat(:));
% (c)
p3c = prod(matA(~isprime(matA)));
% (d)
p3d = matA; p3d(p3d == max(p3d(:)))=min(p3d(:));
%% Problem 4
% (a)
theta = -359:1:720;
x = 20*cosd(theta) + 30*cosd((2*theta)/3); y = 20*sind(theta)-30*sind((2*theta)/3);
dx = diff(x); dy=diff(y); ds = sqrt((dx.^2)+(dy.^2));
p4a = sum(ds);
% (b & c)
dtheta = diff(theta);
p4b = dx./dtheta;
p4c = dy./dtheta;
% d
p4d = sqrt((p4b.^2)+(p4c.^2));
% e
p4e = (0.5*(p4d(1)+p4d(end))+sum(p4d(2:end-1)));
% (f)
p4f = abs(p4a-p4e);
% (g)
figure; hold on; 
plot(x,y,'-b','LineWidth',2);

ind_peak(1) = find(y == max(y));
ind_peak(2) = find(x == min(x) & y > 0);
ind_peak(3) = find(x == min(x) & y < 0);
ind_peak(4) = find(y == min(y));
ind_peak(5) = find(x == max(x));

plot(x(ind_peak),y(ind_peak),'ro','MarkerFaceColor','r','MarkerSize',10);
axis([-50 50 -50 50]); xlabel('x');ylabel('y');
title('Problem 4'); legend('parametric curve','corners of the star','location','northwest');
box on; grid on;
p4g = 'See figure 1';
%% Problem 5
p5 = 'varout = [y z x]';