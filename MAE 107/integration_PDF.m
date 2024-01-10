clear all; clc

%composite trapezoidal rule
T = @(f,x,n,h) h/2*(f(x(1))+2*sum(f(x(2:n)))+f(x(n+1))); 

%standard normal probability density function
f = @(x) 1/sqrt(2*pi)*exp(-x.^2/2);

%error tolerance
eps = 1e-5;

%derivative of f(x)
syms x
fp(x) = diff(f,x);
fp = matlabFunction(fp);

%estimated maximum allowable step size
a = -1; 
b = 1; 
h = sqrt(12*eps/abs(fp(a)-fp(b)));

%numerical integration
n = ceil((b-a)/h);
h = (b-a)/n; %adjusting step size so a + n*h = b.
fprintf('h = %7.10f\n', h);
q = a:h:b; %nodes
T = T(f,q,n,h);
I = int(f,x,a,b);
fprintf('T = %7.10f\n', T);
fprintf('I = %7.10f\n', I);
fprintf('|I - T| = %1.2e\n', abs(I-T));