clear all;
close all;
clc;
format long;
name = 'Levi Stein';
id = 'A16791467';
hw_num = 2;
%% Problem 1:
% (a) Create a 5 x 5 matrix p1a with a value of 9 for every element.
p1a = 9*ones(5,5);
% (b) Copy the matrix in part a into a new matrix p1b. Modify the matrix p1b such that all elements on the second column have a value of 8.
p1b = 9*ones(5,5); p1b(:,2)=[8];
% (c) Transpose the matrix in part (b) and put the answer in p1c.
p1c = transpose(p1b);
% (d) Rotate the matrix in part (b) 90? counterclockwise 3 times and put the answer in p1d.
p1d = rot90(p1b,3);
% (e)Are the matrices in part (c) and (d) the same ? Put the answer in p1e. The answer should be a logical matrix.
p1e = p1c==p1d;
%% Problem 2:
% (a) Create the following matrix and put the answer in p2a. Do not input element by element. 
z1 = [2 3;4 5]; z2 = zeros(2); z3 = 6*ones(2); z4 = fliplr(z1); r12 = [z1 z2 z3 z2 z4];
r4 = [z2 z1 z3 z4 z2]; r56 = [z3 z3 z1 z3 z3]; r78 = [z2 z4 z3 z1 z2]; r910 = [z4 z2 z3 z2 z1]; p2a = [r12;r4;r56;r78;r910];
% (b) Sum all elements on the sixth column of the matrix in part (a) and put the answer in p2b.
p2b = sum(p2a(:,6));
% (c) Sum all elements on the two diagonals of the matrix in part (a) and put the answer in p2c.
p2c = sum(diag(p2a) + diag(p2a'));
% (d) Sum all elements of the matrix in part (a) and put the answer in p2d.
p2d = sum(p2a, 'all');
% (e) How many elements of the matrix in part (a) are greater than 3? Put the answer in p2e.
p2e = sum(p2a(:)>3);
%% Problem 3:
% (a) Create a row vector p3a to store the numerators of each term in the series. Put the answer in p3a.
p3a = [1:2:100];
% (b) Create a row vector p3b to store the denominators of each term in the series. Put the answer in p3b.
p3b = [1 2:2:98];
% (c) Create a row vector p3c to store the signs of each term in the series, e.g. 1 for positive and -1 for negative. Put the answer in p3c.
p3c = (-1).^(2:51); % or repmat([1 -1],1,25)
% (d) Use function sum with the vectors in parts (a-c) to obtain the sum of the series. Put the answer in p3d.
p3d = sum(p3c.*(p3a./p3b));
%% Problem 4:
A = [3 6 11;4 9 6]; B = [9 4;8 5;3 2]; C = [1 2 3;3 5 7;2 4 6]; D = [2 4;4 6];
% (a) Compute A2 and put the result in p4a.
p4a = A.^2;
% (b) Compute A ∗B and put the result in p4b.
p4b = A*B;
% (c) Compute A ∗C and put the result in p4c.
p4c = A*C;
% (d) Compute A ∗D and put the result in p4d.
p4d = 'error';
% (e) Compute B ∗A and put the result in p4e.
p4e = B*A;
% (f) Compute B ∗D and put the result in p4f.
p4f = B*D;
% (g) Compute B ∗C and put the result in p4g.
p4g = 'error';
% (h) Compute C2 and put the result in p4h.
p4h = C.^2;
% (i) Compute D2 and put the result in p4i.
p4i = D.^2;
% (j) Is A ∗B equal to B ∗A ? Put the answer in p4j. The answer should be a logical, look up in MATLAB help isequal.
p4j = isequal(p4b,p4e);
%% Problem 5:
matA = [4 1 1 1; 2 2 5 3; 2 2 7 3; 2 2 5 9]; matB = [1 3 5 7]';
% (a) Using \ operator, solve the system of equations in the form Ax=b to obtain x. Set p5a=x.
p5a = matA\matB;
% (b) Using function inv, solve the system of equations Ax=b for x. Set p5b=x.
p5b = inv(matA)*matB;
% (c) Is the answer in part (a) and part (b) the same? Put the answer in p5c. Hint: Check by setting them equal.
p5c = isequal(p5a,p5b);
% (d) Compute the absolute difference between part (a) and (b) and put the answer in p5d.
p5d = abs(p5a - p5b);
%% Problem 6:
% (a) Create a vector x with values from -2 to 2 with a grid spacing of 0.1 
% and compute f. Use function diff to estimate the derivative and put the answer in p6a.
vecX = -2:0.1:2; f = cos(6*vecX).*exp(-vecX.^2); p6a = diff(f) ./ diff(vecX);
% (b) Repeat part (a) but with a grid spacing of 0.001 and and put the answer in p6b.
vecX1 = round(-2:0.001:2,3); f1 = cos(6*vecX1).*exp(-vecX1.^2); p6b = diff(f1) ./ diff(vecX1);
% (c) Use the answer in part (b) to find the derivative at x = 0.35. Put the answer in p6c.
p6c = p6b(1,2350); %NOTE TO GRADER: I tried using p6b(vecX1 == 0.35) and it continued to give me an empty vector output.
% (d) Use the answer in part (b) to find the value(s) of x where the derivative is most positive. Put the answer in p6d.
maxp6bX = find(p6b == max(p6b)); p6d = vecX1(p6b == max(p6b));
%% Problem 7:
% (a) Create a vector z that has values from -2 to 2 with a grid spacing of 0.1. Compute vector g.
% Estimate the integral and put the answer in p7a.
vecZ = -2:0.1:2; g = (sech(vecZ).^2); dZ = vecZ(2) - vecZ(1); p7a = dZ*(0.5*(g(1)+g(end))+sum(g(2:end-1)));
% (b) Repeat part (a) but with a grid spacing of 0.001. Put the answer in p7b.
vecZ1 = -2:0.001:2; g1 = (sech(vecZ1).^2); dZ1 = vecZ1(2) - vecZ1(1); p7b = dZ1*(0.5*(g1(1)+g1(end))+sum(g1(2:end-1)));