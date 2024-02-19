
%% Problem 0
% I used RR_bode_plot_tests to graph all of these plots

%% Problem 4 part 1
clear; syms L1 L2 L3 L4 L5 x y v w
eqn1= L1*y==v+L2*w;
eqn2= L3*x==L4*y;
eqn3= L5*x-L5*y==v;
sol=solve(eqn1,eqn2,eqn3,x,y,v); G=sol.y/w
pause;

syms K c k s
G=subs(sol.y/w,{L1,L2,L3,L4,L5},{1000*s^2+K, K, c*s+k, c*s+k, c*s+k})
[numG,denG] = numden(G);      % this extracts out the num and den of G
numG=coeffs(numG,s);          % this extracts the powers of s in the num and den
denG=coeffs(denG,s);
numG=simplify(numG/denG(end)); % this makes the den monic
denG=simplify(denG/denG(end));

numG=numG(end:-1:1)   % this reverses the order of the vector of coefficients.
denG=denG(end:-1:1)
pause;
%% Problem 4 part 2
clear; syms L1 L2 L3 L4 L5 x y v w
eqn1= L1*y==v+L2*w;
eqn2= L3*x==L4*y;
eqn3= L5*x-L5*y==v;
sol=solve(eqn1,eqn2,eqn3,x,y,v); G=sol.y/w
pause;

syms c k s
G=subs(sol.y/w,{L1,L2,L3,L4,L5},{1000*s^2+1000, 1000, 100*s^2+c*s+k, c*s+k, c*s+k})
[numG,denG] = numden(G);      % this extracts out the num and den of G
numG=coeffs(numG,s);          % this extracts the powers of s in the num and den
denG=coeffs(denG,s);
numG=simplify(numG/denG(end)); % this makes the den monic
denG=simplify(denG/denG(end));

numG=numG(end:-1:1)   % this reverses the order of the vector of coefficients.
denG=denG(end:-1:1)
pause;

%% Fiddling around
clear; syms L1 L2 L3 L4 L5 x y v w
eqn1= L1*y==v+L2*w;
eqn2= L3*x==L4*y;
eqn3= L5*x-L5*y==v;
sol=solve(eqn1,eqn2,eqn3,x,y,v); G=sol.y/w
pause;

syms c k s
G=subs(sol.y/w,{L1,L2,L3,L4,L5},{1000*s^2+1000, 1000, 100*s^2+40*s+100, 40*s+100, 40*s+100})
[numG,denG] = numden(G);      % this extracts out the num and den of G
numG=coeffs(numG,s);          % this extracts the powers of s in the num and den
denG=coeffs(denG,s);
numG=simplify(numG/denG(end)); % this makes the den monic
denG=simplify(denG/denG(end));

numG=numG(end:-1:1)   % this reverses the order of the vector of coefficients.
denG=denG(end:-1:1)
figure(1);
F = RR_tf([1, 2/5, 1],[1, 11/25, 21/10, 2/5, 1]);
RR_bode(F);

 % Plotting impulse and step response to the system
[b] = [2/5, 1];
[p] = RR_roots([1, 11/25, 21/10, 2/5, 1]);
d1 = (p(1)^2+b(1)*p(1)+b(2))/((p(1)-p(2))*(p(1)-p(3))*(p(1)-p(4)));
d2 = (p(2)^2+b(1)*p(2)+b(2))/((p(2)-p(1))*(p(2)-p(3))*(p(2)-p(4)));
d3 = (p(3)^2+b(1)*p(3)+b(2))/((p(3)-p(1))*(p(3)-p(2))*(p(3)-p(4)));
d4 = (p(4)^2+b(1)*p(4)+b(2))/((p(4)-p(1))*(p(4)-p(2))*(p(4)-p(3)));


y = @(t) d1*exp(p(1)*t) + d2*exp(p(2)*t) + d3*exp(p(3)*t) + d4*exp(p(4)*t);
t = 0:0.1:100;
figure(2);
plot(t,y(t),'b-');

[b] = [2/5, 1];
[p] = RR_roots([1, 11/25, 21/10, 2/5, 1]);
d1 = (p(1)^2+b(1)*p(1)+b(2))/(p(1)*(p(1)-p(2))*(p(1)-p(3))*(p(1)-p(4)));
d2 = (p(2)^2+b(1)*p(2)+b(2))/(p(2)*(p(2)-p(1))*(p(2)-p(3))*(p(2)-p(4)));
d3 = (p(3)^2+b(1)*p(3)+b(2))/(p(3)*(p(3)-p(1))*(p(3)-p(2))*(p(3)-p(4)));
d4 = (p(4)^2+b(1)*p(4)+b(2))/(p(4)*(p(4)-p(1))*(p(4)-p(2))*(p(4)-p(3)));
d5 = (b(2))/(p(1)*p(2)*p(3)*p(4));
hold on;
y = @(t) d1*exp(p(1)*t) + d2*exp(p(2)*t) + d3*exp(p(3)*t) + d4*exp(p(4)*t) + d5;
t = 0:0.1:100;
plot(t,y(t),'o-');


