clear all;
close all;
clc;
format long;
name = 'Levi Stein';
id = 'A16791467';
hw_num = 1;
%% Problem 1:
% (a) π divided by 0, put the answer in p1a.
p1a = pi/0;
% (b) 0 divided 0, put the answer in p1b.
p1b = 0/0;
% (c) Square root of −3π, put the answer in p1c.
p1c = sqrt(-3*pi);
% (d) Cosine of 55◦, put the answer in p1d.
p1d = cosd(55);
% (e) Sine of 3π/4 radians, put the answer in p1e.
p1e = sin((3*pi)/4);
% (f) 4321 raised to the 5th power, put the answer in p1f.
p1f = 4321^5;
% (g) Ninth root of 512, put the answer in p1g.
p1g = nthroot(512, 9);
% (h) Logarithm of 32,768 using base 2, put the answer in p1h.
p1h = log2(32768);
% (i) Logarithm of 1,000,000,000 using base 10, put the answer in p1i.
p1i = log10(1000000000);
% (j) Natural logarithm of Euler.s number, put the answer in p1j.
p1j = reallog(exp(1));
% (k) Inverse tangent of 1, put the answer (in degrees) in p1k.
p1k = atand(1);
% (l) Hyperbolic sine of 5, put the answer in p1l.
p1l = sinh(5);
% (m) Inverse hyperbolic tangent of 1, put the answer in p1m.
p1m = atanh(1);
%% Problem 2:
% (a) Typecast real number 12π into character type and put the answer in p2a.
p2a = '12*pi';
% (b) Typecast real number 16.32 into character type and put the answer in p2b.
p2b = '16.32';
% (c) Typecast the answer in part (b) into double-precision type and put the answer in p2c.
p2c = double(p2b);
% (d) Typecast character X into 32-bit integer type and put the answer in p2d.
p2d = int32('X');
% (e) Typecast character Y into 64-bit integer type and put the answer in p2e.
p2e = int64('Y');
% (f) Typecast character Z into single-precision real type and put the answer in p2f.
p2f = single('Z');
% (g) Typecast character Z into double-precision real type and put the answer in p2g.
p2g = double('Z');
% (h) Use function class to find the data type of variable p2a and put the answer in p2h.
p2h = class(p2a);
% (i) Compute the product of character Y and character Z. Put the answer in p2i.
p2i = 'Y'*'Z';
% (j) Is double('X') equal to int64('X')? Put the answer in p2j.
p2j = double('X')==int64('X');
%% Problem 3:
% (a) Character x is equal to character X. Put the answer in p3a.
p3a = 'x'=='X';
% (b) Character z is larger than character Y . Put the answer in p3b.
p3b = 'z'>'Y';
% (c) Character z is smaller than character y. Put the answer in p3c.
p3c = 'z'<'y';
% (d) log2(2048) is equal to 11. Put the answer in p3d.
p3d = log2(2048) == 11;
% (e) sin(100π) is not equal to 0. Put the answer in p3e.
p3e = sin(100*pi) ~= 0;
% (f) 2\8 + 1 is less than 3. Put the answer in p3f.
p3f = (2\8 + 1) < 3;
% (g) 2/8 + 1 is less than 3. Put the answer in p3g.
p3g = (2/8 + 1) < 3;
a = 3; b = 4; c = 5;
% (h) a is greater than than both b and c. Put the answer in p3h.
p3h = a > b && c;
% (i) a is less than b and a is greater than c. Put the answer in p3i.
p3i = a < b && a > c;
% (j) a is greater than b or a is greater than c or both. Put the answer in p3j.
p3j = a > b || a > c || a > b && c;
% (k) a is greater than b but not less than c. Put the answer in p3k. 
p3k = a > b && a >= c;
% (l) a is exclusively smaller than b or c. Put the answer in p3l.
p3l = a < xor(b,c);
%% Problem 4:
% (a) Is fix(6.5) the same as floor(6.5)? Put the answer in p4a.
p4a = fix(6.5) == floor(6.5);
% (b) Is fix(6.4) the same as fix(-6.4)? Put the answer in p4b.
p4b = fix(6.4) == fix(-6.4);
% (c) Is fix(6.2) the same as floor(6.2)? Put the answer in p4c.
p4c = fix(6.2) == floor(6.2);
% (d) Is fix(-6.2) the same as floor(-6.2)? Put the answer in p4d.
p4d = fix(-6.2) == floor(-6.2);
% (e) Is fix(-6.2) the same as ceil(-6.2)? Put the answer in p4e.
p4e = fix(-6.2) == ceil(-6.2);
% (f) Is rem(6,4) the same as mod(6,4)? Put the answer in p4f.
p4f = rem(6,4) == mod(6,4);
% (g) Is rem(6,-4) the same as mod(6,-4)? Put the answer in p4g.
p4g = rem(6,-4) == mod(6,-4);
%% Problem 5:
% (a) Which comes first - lower-case or upper-case letters? Use the strings 'lower'or 'upper' for your response. Put the answer in p5a.
p5a = 'upper';
% (b) What is the absolute integer offset value between lower-case and upper-case letters? Put the answer in p5b.
p5b = 32;
% (c) Is the answer from part (b) the same throughout the letter alphabet? The answer should be a logical statement, and put it in p5c.
p5c = double('a')- double('A') == double('z')- double('Z');
%% Problem 6:
% (a) What is the value of x? Put the answer in p6a.
r = 10; theta = 84; x = r*cosd(theta); y = r*sind(theta);
p6a = x;
% (b) What is the value of y? Put the answer in p6b.
p6b = y;
%% Problem 7:
% (a) Using the colon operator, create a row vector p7a containing even integer numbers from 1900 to 2022.
p7a = [1900:2:2022];
% (b) Using function linspace, create a row vector p7b containing odd integer numbers from 1901 and 2021.
p7b = linspace(1901, 2021, 61);
% (c) Concatenate the vectors created in parts (a) and (b) and put the answer in vector p7c.
p7c = [p7a p7b];
% (d) What is the length of the vector in part (c) ? Put the answer to p7d.
p7d = length(p7c);
% (e) Add the number 2023 to the end of the vector in part (c) to create vector p7e.
p7e = [p7c 2023];
% (f) Extract the first half of the vector in part (e) and put the answer in vector p7f.
p7f = p7e(1:62);
% (g) Extract the second half of the vector in part (e) and put the answer in vector p7g.
p7g = p7e(63:124);
%% Problem 8:
% (a) Create a column vector p8a with the first element equal to 10π, the last element equal to −10π, and the difference between two consecutive elements equal to 2π by entering all of elements.
p8a = [10*pi;8*pi;6*pi;4*pi;2*pi;0;-2*pi;-4*pi;-6*pi;-8*pi;-10*pi];
% (b) Create a column vector p8b with the first element equal to 10π, the last element equal to −10π, and the difference between two consecutive elements equal to 2π by using function linspace.
p8b = linspace(10*pi,-10*pi,11)';
% (c) Create a column vector p8c with the first element equal to 10π, the last element equal to −10π, and the difference between two consecutive elements equal to 2π by using the colon operator.
p8c = [(10*pi):(-2*pi):(-10*pi)]';
% (d) Create a column vector p8d with all the even numbers starting from 2016 decreasing to 2.
p8d = [2016:-2:2]';
% (e) Square all of the elements of the vector in part (d) and put the answer in p8e.
p8e = p8d.^2;
% (f) Sum all elements of the vector in part (e) and put the answer in p8f.
p8f = sum(p8e);
% (g) Find the product of the last ten elements of the vector in part (e) and put the answer in p8g.
p8g = (4*16*36*64*100*144*196*256*324*400);
% (h) Find the cumulative sum of the vector in part (e). Put the answer in p8h.
p8h = cumsum(p8e);