clear all;
close all;
clc;
format long;
name = 'Levi Stein';
id = 'A16791467';
hw_num = '6';
%% Problem 1
% (a) In the following inequality equations, n is a positive integer. Use while loop to find the 
% smallest value of n that satisfies the equations.
a = 1;
while exp(1)/factorial(2*a+1) >= 10^(-9)
    a = a + 1;
end
p1a = a;
% (b)
b = 1;
while (b^2)*log(b^2) <= 10^9
    b = b +1;
end
p1b = b;
%% Problem 2
% (a & b) Find the smallest value of k such that the absolute error is less than 10−7.
% Here, the absolute error is defined as the absolute difference between the approximate value
% and the MATLAB built-in value 
pi1 = 0;
k1 = 0;
while abs(pi - pi1) >= 10^-7
    pi1 = pi1 + 4*(-1)^k1/(2*k1 + 1);
    k1 = k1 + 1;
end
k1 = k1 - 1;
p2a = pi1;
p2b = k1;
% (c & d)
pi2 = 0;
k2 = 0;
while abs(pi - pi2) >= 10^-7
    pi2 = pi2 + sqrt(12)*(-3)^(-k2)/(2*k2 + 1);
    k2 = k2 + 1;
end
k2 = k2 - 1;
p2c = pi2;
p2d = k2;
% (e)
p2e = 'The series in part (c) converges faster';
%% Problem 3
load('stringA.mat');
% (a - c) How many times do the substrings 'but', 'not', and 'for' appear in stringA?
% Put the answers into p3a, p3b, and p3c, respectively.
counter_but = 0;
counter_not = 0;
counter_for = 0;
for n = 1:length(stringA)-2
    switch stringA(n:n+2)
        case 'but'
            counter_but = counter_but + 1;
        case 'not'
            counter_not = counter_not + 1;
        case 'for'
            counter_for = counter_for + 1;
    end
end
p3a = counter_but;
p3b = counter_not;
p3c = counter_for;
% (d - f) How many times do the substrings 'these', 'times', and 'loops' appear in 
% stringA? Put the answers into p3d, p3e, and p3f, respectively.
counter_these = 0;
counter_times = 0;
counter_loops = 0;
for n = 1:length(stringA)-4
    switch stringA(n:n+4)
        case 'these'
            counter_these = counter_these + 1;
        case 'These'
            counter_these = counter_these + 1;
        case 'times' 
            counter_times = counter_times + 1;
        case 'loops'
            counter_loops = counter_loops + 1;
        case 'Loops'
            counter_loops = counter_loops + 1;
    end
end
p3d = counter_these;
p3e = counter_times;
p3f = counter_loops;
%% Problem 4
load('terrain.mat');
% (a - d) How many peaks (i.e. local maxima) are there on the terrain?
counter = 0;
for n = 2:length(x)-1
    for m = 2:length(y)-1
        nb(1) = altitude(n+1,m-1);
        nb(2) = altitude(n+1,m);
        nb(3) = altitude(n+1,m+1);
        nb(4) = altitude(n,m+1);
        nb(5) = altitude(n-1,m+1);
        nb(6) = altitude(n-1,m);
        nb(7) = altitude(n-1,m-1);
        nb(8) = altitude(n,m-1);
        if altitude(n,m) >= max(nb)
            counter = counter + 1;
            x_loc_max(counter) = x(n);
            y_loc_max(counter) = y(m);
            alt_loc_max(counter) = altitude(n,m);
        end
    end
end
p4a = numel(alt_loc_max);
p4b = x_loc_max;
p4c = y_loc_max;
p4d = alt_loc_max;
% (e - h) How many troughs (i.e. local minima) are there on the terrain?
counter = 0;
for n = 2:length(x)-1
    for m = 2:length(y)-1
        nb(1) = altitude(n+1,m-1);
        nb(2) = altitude(n+1,m);
        nb(3) = altitude(n+1,m+1);
        nb(4) = altitude(n,m+1);
        nb(5) = altitude(n-1,m+1);
        nb(6) = altitude(n-1,m);
        nb(7) = altitude(n-1,m-1);
        nb(8) = altitude(n,m-1);
        if altitude(n,m) <= min(nb)
            counter = counter + 1;
            x_loc_min(counter) = x(n);
            y_loc_min(counter) = y(m);
            alt_loc_min(counter) = altitude(n,m);
        end
    end
end
p4e = numel(alt_loc_min);
p4f = x_loc_min;
p4g = y_loc_min;
p4h = alt_loc_min;
% (i)
figure;hold on;
surf(x,y,altitude'); shading interp;
plot3(x_loc_max,y_loc_max,alt_loc_max,'ro','MarkerFaceColor','r');
plot3(x_loc_min,y_loc_min,alt_loc_min, 'go','MarkerFaceColor','g');
xlabel('x (meters)');ylabel('y (meters)');zlabel('altitude (meters)');
title('Local Max & Min of Terrain Data');
legend('altitude(x,y)','Local Maximum','Local Minimum','Location','best');
view(3);
p4i = 'See figure 1';
%% Problem 5
% (a & b)
[p5a, p5b] = word_search('FLOWER');
% (c & d)
[p5c, p5d] = word_search('JUICE');
% (e & f)
[p5e, p5f] = word_search('RULES');
