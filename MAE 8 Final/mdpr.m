clear all;
close all;
clc;
format long;
name = 'Levi Stein';
id = 'A16791467';
hw_num = 0;
%% 1
dnt = clock;
string = 'I affirm that I will not give or recieve any unauthorized help on this exam, and that all work will be my own';
p1 = sprintf('At %02d:%02d:%02.0f on %4d:%02d:%02d,%s',...
    dnt(4:6),dnt(1:3),string);
%% 2
%a
n = 1:100;
p2a = n;
%b
p2b = (3.^(n+1)).*(n+1);
%c Find the index of the first element in p2b that is greater than 1020. Put the answer in p2c.
[r,c] = find(p2b > 10^(20));
p2c = [r(1), c(1)];
%% 3
matA = 1:225; matA = abs(ceil(100*cos(matA/10))); matA = reshape(matA,15,15);
%a Extract elements on the last row of matA and put them in vector p3a.
p3a = matA(end,:);
%b Extract elements on the main diagonal of matA and put them in vector p3b.
p3b = diag(matA)';
%c Extract the second, fourth, and sixth columns of matA and put them in matrix p3c
p3c = [matA(:,2) matA(:,4) matA(:,6)]; % p3c = [matA(:,2:2:6)];
%d Is there any element in matA that is divisible by 11? Put the answer in p3d. The answer should be a single logical value.
p3d = any(any(rem(matA, 11)));
%e Copy matA into p3e. Modify p3e so that its maximum value(s) increases by 20.
p3e = matA; p3e(p3e == max(p3e(:))) = max(p3e(:)) + 20;
%% 4
%a&b
x = -7200:10:7200;
f = cosd((x+360)/360).*exp(-1*(x/3600).^2);
p4a = x; p4b = f;
%c Use vectors f and x to find the value of x where f(x) increases the fastest. Put the answer in p4c. Hint: f(x) increases the fastest where f (x) is maximum.
dfdx = diff(f)./diff(x);
p4c = x(dfdx == max(dfdx));
%d Use vectors f and x to estimate the integral Rf (x) dx for all xUs and put the answer in p4d. Use trapezoidal method as discussed in class.
p4d = 10*(0.5*(f(1)+f(end))+sum(f(2:end-1)));
%% 5
x1 = linspace(-2,2,100);
y = 2*sech(x1).^2; y1 = abs(2*x1.^3)-1;
figure; hold on;
plot(x1,y,'--k',x1,y1,':k');
plot(x1(y>y1),y(y>y1),'ko','MarkerFaceColor','k');
plot(x1(y>y1),y1(y>y1),'ko','MarkerFaceColor','k');
axis([-2 2 -2 4]);
xlabel('x');ylabel('y'); title('Solution to system of nonlinear inequality equations');
legend('y = 2*sech(x1).^2','y = abs(2*x1.^3)-1','solution boundaries','location','best');
box on; grid on; hold off;
p5a = 'see figure 1';
p5b = [min(x1(y>y1)) max(x1(y>y1))];