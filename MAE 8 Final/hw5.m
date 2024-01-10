clear all;
close all;
clc;
format long;
name = 'Levi Stein';
id = 'A16791467';
hw_num = '5';
%% Problem 1:
% (a) 'Fibonacci series' Compute the first 25 terms of the series 
p1a(1) = 1;
p1a(2) = 1;
for n = 3:25
   p1a(n) = p1a(n-1)+p1a(n-2);
end
% (b) Find the sum of all terms in the series in part (a) 
p1b = 0;
for n = 3:25
    p1a(n) = p1a(n-1)+p1a(n-2);
    p1b = p1b +p1a(n)+2;
end
% (c) Find the product of all terms in the series in part (a) 
p1c = 1;
for n = 3:25
    p1a(n) = p1a(n-1)+p1a(n-2);
    p1c = p1c*p1a(n);
end
% (d) Find the ratio of two consecutive terms in the series in part (a) 
for n = 3:25
    p1d(1) = 0;
    p1d(2) = p1a(2)/p1a(1);
    p1d(n) = p1a(n)/p1a(n-1);
end
%% Problem 2: Use for loop or nested for loops to evaluate the following expressions
% (a) 
p2a = 1;
for n = 1:50
    a(n) = (4*n^2)/((4*n^2)-1);
    p2a = p2a*a(n);
end
% (b)
p2b = 0;
for n = 1:100
    b(n) = (1/((n^2)+n));
    p2b = p2b + b(n);
end
% (c)
p2c = 0;
for m = 0:50
    for n = 0:50
        p2c = p2c + (1/(3^(m+n)));
    end
end
% (d)
p2d = 0;
for m = 0:50
    for n = 0:m
        p2d = p2d + (1/(3^(m+n)));
    end
end
% (e)
p2e = 0;
for l = 1:50
    for m = 1:30
        for n = 1:30
            p2e = p2e + 1/(2^(l+m+n));
        end
    end
end
%% Problem 3
% (a)
p3a(1) = sqrt(2);
for i = 1:9
    p3a = sqrt(2 + p3a);
end
% (b)
p3b = 1;
for i = 1:9
    p3b = sqrt(1+2*p3b);
end
% (c)
p3c = sqrt(2);
for i = 1:9
    p3c = sqrt(2+(-1)^i*p3c);
end
%% Problem 4
% (a) Create the 3-D function M (x,y,z)
x = -2:0.01:2; y = -1:0.01:1; z = 0:0.01:1;
M = zeros(length(x),length(y),length(z));
for l = 1:length(x)
    for m = 1:length(y)
        for n = 1:length(z)
            M(l,m,n) = exp(-1*(sin(2*x(l))*cos(4*y(m))*tanh(z(n)))^2);
        end
    end
end
p4a = M;
% (b) Compute the average value of M over the entire domain.
sum_tmp = 0;
counter = 0;
for l = 1:length(x)
    for m = 1:length(y)
        for n = 1:length(z)
            counter = counter + 1;
            sum_tmp = sum_tmp + M(l,m,n);
        end
    end
end
p4b = sum_tmp/counter;
% (c) Compute the average value of M along the z-direction
M_avg_z = zeros(length(x),length(y));
for l = 1:length(x)
    for m = 1:length(y)
        sum_tmp = 0;
        counter = 0;
        for n = 1:length(z)
          counter = counter + 1;
          sum_tmp = sum_tmp + M(l,m,n);
        end
        M_avg_z(l,m) = sum_tmp/counter;
    end
end
p4c = M_avg_z;
% (d)
figure; hold on;
surf(x,y,p4c'); shading interp;
xlabel('x');ylabel('y');zlabel('M avg along z');
title('Problem 4 HW 5');
p4d = 'See figure 1'; view(3);
%% Problem 5
% (a) A ball is released from a 10 m high roof and bounces two thirds as high on 
% each successive bounce. After traveling a total of 40 m (up and down motion), how many
% times did the ball bounce (e.g. touch the ground)? Put the answer in p5a. How high did
% the ball go before the last bounce? Put the answer in p5b. Use while loop.
startheight = 10;
distance = 0;
e = 2/3;
n = 0;
while (distance < 40)
    if (mod(n,2) == 0)
        distance = distance + startheight;
    else
        startheight = startheight*e;
        distance = distance + startheight;
    end
    n = n + 1;
end
p5a = n/2;
% (b)
while ((n/2) < 4)
    if (mod(n,2) == 0)
        distance = distance + startheight;
    else
        startheight = startheight*e;
        distance = distance + startheight;
    end
    n = n + 1;
end
p5b = startheight;