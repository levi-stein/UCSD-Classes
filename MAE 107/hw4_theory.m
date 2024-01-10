clear all;
close all;
clc;
format long;
%% 2
x = linspace(0,1,5);
h = 1/4;
n = 5;
M = zeros(n);
u = -(2+h^2);
diag = linspace(u,u,5);
M(1:(n+1):end) = diag;
subdiag = linspace(1,1,4);
M(2:(n+1):end) = subdiag;
M(end,(end-1)) = 0;
superdiag = subdiag;
M((n+1):(n+1):end) = superdiag;
M(1,2) = 0;

for i = 1:5
    rhs(i) = (-h^2)*x(i);
end

M(1) = 1;
rhs(1) = 0;
M(end) = 1;
rhs(end) = 0;

y = M\rhs';


