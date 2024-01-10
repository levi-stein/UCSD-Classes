clear all;
close all;
clc;
format long;
name = 'Levi Stein';
id = 'A16791467';
hw_num = 3;
%% Problem 1
load('air_temperature (1).mat');
sprime_x1 = -0.0065;
sprime_xn = 0;
% (a) Estimate the air temperature at altitude = 12,000 m using all knots. Put the answer in p1a.
xi = altitude;
yi = temperature;
p1a = clamped_cubic_spline(xi,yi,sprime_xn,sprime_x1,12000);
% (b)
z = 0:100:20000;
for n = 1:length(z)
    T(n) = clamped_cubic_spline(xi,yi,sprime_xn,sprime_x1,z(n));
end
figure; hold on;
plot(T,z,'-k','LineWidth',2);
plot(yi,xi,'ro','MarkerFaceColor','r');
xlabel('Temperature (C)');ylabel('Altitude (m)');
title('Cubic Clamped Spline Interpolation of Air Temperature Data');
legend('Cubic Spline','knots');
p1b = 'See figure 1';
% (c) Comment on the difference between the cubic spline interpolation result seen here
% and the Lagrange interpolation result obtained in problem 2 of homework 2 programming component.
p1c = ['It seems that the cubic spline interpolation approximates the value of temperature better than Lagrange interpolation as seen in the previous hw2. ' ...
    'As seen on the graph between 12000-20000 meters, temperature remains constant. ' ...
    'Lagrange interpolation caused the polynomial to have a large jump in this region.'];

