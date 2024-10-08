close all; clear; clc;
F1 = RR_tf(1, [1 2 2 1]);
U1 = RR_tf(1, [1 0]);
Y1 = F1*U1;
[p,d,k,n]=RR_partial_fraction_expansion(Y1);
RR_step(F1);
syms z
a = 10*RR_tf([1 -1]);
b = RR_tf(1,[1 1]);
sa = a*b;
F1a = 1/(sa^3 + 2*sa^2 + 2*sa + 1);

f = (2*(1 - cos(1.6))/((1.6)*sin(1.6)));
a1 = (10/f)*RR_tf([1 -1]);
b1 = RR_tf(1,[1 1]);
sb = a1*b1;
F1b = 1/(sb^3 + 2*sb^2 + 2*sb + 1);

U2 = RR_tf(1,[1 -1]);
Y2 = F1a*U2;
[pf,df,kf,nf]=RR_partial_fraction_expansion(Y2);
% p = [0.818181818181758  (0.891891891891879 - 0.156040613294530i)  (0.891891891891879 + 0.156040613294530i) 1];
% b = [0.000819000819001 0.002457002457002 0.002457002457002 0.000819000819001];
% d1 = df(1)/pf(1);
% d2 = df(2)/pf(2);
% d3 = df(3)/pf(3);
% d0 = df(4)/pf(4);

y(1) = df(1) + df(2) + df(3) + df(4);
t(1) = 0;

for n = 1:50
    t(n+1) = t(n) + 0.2;
    y(n+1) = df(1)*pf(1)^n + df(2)*pf(2)^n + df(3)*pf(3)^n + df(4);
end
figure(2);
plot(t,y,'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 2);