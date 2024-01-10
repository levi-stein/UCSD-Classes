clear all;
close all;
clc;
format long;
name = 'Levi Stein';
id = 'A16791467';
hw_num = 2;
%% Problem 1
% (a) Calculate the specific volumes for P = [50000:10000:200000] Pa and T = [300:100:1000] K. Put the result into a 2D matrix p1a.
P = [50000:10000:200000]; T = [300:100:1000];
for i = 1:length(P)
    for j = 1:length(T)
        vn(i,j) = van_der_Waals(P(i),T(j));
    end
end
p1a = vn;
% (b) 
p1b ='See figure 1';
surf(P,T,vn');
xlabel('Pressure (Pa)');ylabel('Temperature (K)');zlabel('Specific Volume (m^3/kg)');
title('Specific Volume from Van der Waals using Newton')
shading interp;

%% Problem 2
load('air_temperature.mat');
xi = altitude;
yi = temperature;
% (a) Estimate the temperature at altitude z = 12,000 m using nodes 9 through 11. Put the answer in p2a.
p2a = lagrange_interp(xi(10:12), yi(10:12), 12000);
% (b) Estimate the temperature at altitude z = 12,000 m using nodes 9 through 12. Put the answer in p2b.
p2b = lagrange_interp(xi(10:13), yi(10:13), 12000);
% (c) Estimate the temperature at altitude z = 12,000 m using all nodes.
% Put the answer in p2c.
p2c = lagrange_interp(xi, yi, 12000);
% (d) Estimate the temperature for every element in vector z and store them in vector T...
% Use a solid line to plot T versus z with z on the vertical axis and T on the horizontal axis. 
z = [0:100:20000];
for i = 1:length(z)
    T(i) = lagrange_interp(xi, yi, z(i));
end
figure;
plot(T,z,'-k','LineWidth',2); xlabel('Temperature (C)');ylabel('Altitude (m)'); title('Temperature vs. Altitude Lagrange Interpolation');
hold on;
for i = 1:length(xi)
    plot(temperature(i),altitude(i),'ro','MarkerFaceColor','r');
end

% (e) Based on the figure, comment on the accuracy of the interpolation. Give the answer as p2e = '...'.

p2e = ['I believe that the the interpolation is a very inaccurate as we can see with that huge jump in temperature between 15000 and 200000 meters.' ...
    'I believe this is because we are trying to fit every point on a polynomial.' ...
    'A best fit line may be a little more accurate for the higher alititudes, as temperatures may stay the same for these heights.'];