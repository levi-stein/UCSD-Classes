clear all;
close all;
clc;
format long;
name = 'Levi Stein';
id = 'A16791467';
hw_num = 4;
%% Problem 1:
% (a) ∼(a||b) == ∼a|| ∼b
p1a = false;
% (b) ∼(a&& b) == (∼a||∼b)
p1b = true; 
% (c) ∼(a||b) == (∼a&& ∼b)
p1c = true;
% (d) ∼(a||b) == (∼a||∼b)
p1d = false;
% (e) ∼(a||b) == ∼a&& ∼b
p1e = true;
%% Problem 2:
% (a) ∼all(v) == any(∼v)
p2a = true;
% (b) ∼any(v) == all(∼v)
p2b = true;
% (c) ∼(all(v) && any(v)) == (∼all(v) || ∼any(v))
p2c = true;
% (d) ∼(all(v) ||any(v)) == (∼all(v) && ∼any(v))
p2d = false;
% (e) ∼(all(v) && any(v)) == (∼all(v) ||any(v))
p2e = true;
%% Problem 3:
% (a) Set p3a=evalc('help divisibility')
p3a =evalc('help divisibility');
% (b) Check the divisibility of 66 and set the answer to p3b
p3b = divisibility(66);
% (c) Check the divisibility of 385 and set the answer to p3c
p3c = divisibility(385);
% (d) Check the divisibility of 3855 and set the answer to p3d
p3d = divisibility(3855);
% (e) Check the divisibility of 232155 and set the answer to p3e
p3e = divisibility(232155);
% (f) Check the divisibility of 2297295 and set the answer to p3f
p3f = divisibility(2297295);
%% Problem 4:
% (a) Set p4a=evalc('help piecewise2d').
p4a = evalc('help piecewise2d');
% (b) Set p4b=piecewise2d(π,π)
p4b=piecewise2d(pi,pi);
% (c) Set p4c=piecewise2d(π, −π)
p4c=piecewise2d(pi, -pi);
% (d) Set p4d=piecewise2d(−π,π)
p4d=piecewise2d(-pi,pi);
% (e) Set p4e=piecewise2d(−π,−π)
p4e=piecewise2d(-pi,-pi);
% (f) Set p4f=piecewise2d(0,0)
p4f=piecewise2d(0,0);
% (g) Set p4g=piecewise2d(0,π)
p4g=piecewise2d(0,pi);
% (h) Set p4h=piecewise2d(0,−π)
p4h=piecewise2d(0,-pi);
% (i) Set p4i=piecewise2d(π,0)
p4i=piecewise2d(pi,0);
% (j) Set p4j=piecewise2d(−π,0)
p4j=piecewise2d(-pi,0);
%% Problem 5:
% (a) Set p5a = evalc('help lottery')
p5a = evalc('help lottery');
% (b) Set p5b = lottery([2, 3, 4, 5, 6, 7])
p5b = lottery([2, 3, 4, 5, 6, 7]);
% (c) Set p5c = lottery([12, 23, 24, 34, 50, 61])
p5c = lottery([12, 23, 24, 34, 50, 61]);
% (d) Set p5d = lottery([22, 33, 44, 50, 51, 61])
p5d = lottery([22, 33, 44, 50, 51, 61]);
% (e) Set p5e = lottery([32, 43, 54, 44, 51, 61])
p5e = lottery([32, 43, 54, 44, 51, 61]);
% (f) Set p5f = lottery([42, 53, 34, 44, 51, 61])
p5f = lottery([42, 53, 34, 44, 51, 61]);
% (g) Set p5g = lottery([42, 23, 34, 44, 51, 61])
p5g = lottery([42, 23, 34, 44, 51, 61]);
% (h) Set p5h = lottery([12, 23, 34, 44, 51, 61])
p5h = lottery([12, 23, 34, 44, 51, 61]);
%% Problem 6:
% (a) Set p6a=evalc('help rgb color')
p6a=evalc('help rgb_color');
% (b) Set p6b=rgb color([1 1 1])
p6b=rgb_color([1 1 1]);
% (c) Set p6c=rgb color([1 0 0])
p6c=rgb_color([1 0 0]);
% (d) Set p6d=rgb color([0 1 0])
p6d=rgb_color([0 1 0]);
% (e) Set p6e=rgb color([0 0 1])
p6e=rgb_color([0 0 1]);
% (f) Set p6f=rgb color([1 1 0])
p6f=rgb_color([1 1 0]);
% (g) Set p6g=rgb color([0 1 1])
p6g=rgb_color([0 1 1]);
% (h) Set p6h=rgb color([1 0 1])
p6h=rgb_color([1 0 1]);
% (i) Set p6i=rgb color([0 0 0])
p6i=rgb_color([0 0 0]);
%% Problem 7:
% (a) Set p7a=evalc('help days in month')
p7a=evalc('help days_in_month');
% (b) Set p7b=days in month('jan',0)
p7b=days_in_month('jan',0);
% (c) Set p7c=days in month('feb',0)
p7c=days_in_month('feb',0);
% (d) Set p7d=days in month('feb',1)
p7d=days_in_month('feb',1);
% (e) Set p7e=days in month('apr',0)
p7e=days_in_month('apr',0);
% (f) Set p7f=days in month('aug',1)
p7f=days_in_month('aug',1);
% (g) Set p7g=days in month('oct',0)
p7g=days_in_month('oct',0);
% (h) Set p7h=days in month('nov',1)
p7h=days_in_month('nov',1);
% (i) Set p7i=days in month('Dec',0)
p7i=days_in_month('Dec',0);
%% Problem 8:
p8 = evalc('type(''survey.dat'')');