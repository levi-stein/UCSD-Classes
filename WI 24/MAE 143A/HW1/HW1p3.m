%% Problem 3 & 4
clear; syms L1 L2 L3 L4 L5 L6 L7 L8 L9 x y z u
eqn1= L1*x+L2*y==0;
eqn2= L3*x+L4*y+L5*z==0;
eqn3= L6*x+L7*y+L8*z==L9*u;
sol=solve(eqn1,eqn2,eqn3,x,y,z); G=sol.y/u
pause;

syms o b xbar ybar zbar s
G=subs(sol.y/u,{L1,L2,L3,L4,L5,L6,L7,L8,L9},{s+o, -o, zbar, s+1, xbar, -ybar, -xbar, s+b, -b})
[numG,denG] = numden(G);      % this extracts out the num and den of G
numG=coeffs(numG,s);          % this extracts the powers of s in the num and den
denG=coeffs(denG,s);
numG=simplify(numG/denG(end)); % this makes the den monic
denG=simplify(denG/denG(end));

numG=numG(end:-1:1)   % this reverses the order of the vector of coefficients.
denG=denG(end:-1:1)

sym_poles = RR_roots(denG); %these are the symbolic poles

denG1 = [1, 6, 47+1+4+4-4, 4*(47+47+1-1)];
RR_roots(denG1); % poles for 1st eq. point
denG2 = [1, 6, 47+1+4+4-4, 4*(47+47+1-1)];
RR_roots(denG2); % poles for 2nd eq. point (note: they are equal to poles of 1st eq. point)
denG3 = [1, 6, 1+4+4+4*(-48), 4*(1-48)];
RR_roots(denG3); % poles for 3rd eq. point

%% Problem 6 plotting
t = 1:100;
% equil point 1
[p] = RR_roots(denG1);
b1 = 1*sqrt(47); b0 = 1*4*sqrt(47);
d1 = (b1*p(1)+b0)/((p(1)-p(2))*(p(1)-p(3))*p(1));
d2 = (b1*p(2)+b0)/((p(2)-p(1))*(p(2)-p(3))*p(2));
d3 = (b1*p(3)+b0)/((p(3)-p(1))*(p(3)-p(2))*p(3));
d0 = b0/(-1*p(1)*p(2)*p(3));

y = @(t) d1*exp(p(1)*t) + d2*exp(p(2)*t) + d3*exp(p(3)*t) + d0; % define our inverse laplace transform y'(t)
plot(t,y(t),'b-')

% equil point 2 has same poles as equil point 1
hold on;
b1 = -1*sqrt(47); b0 = -1*4*sqrt(47);
d1 = (b1*p(1)+b0)/((p(1)-p(2))*(p(1)-p(3))*p(1));
d2 = (b1*p(2)+b0)/((p(2)-p(1))*(p(2)-p(3))*p(2));
d3 = (b1*p(3)+b0)/((p(3)-p(1))*(p(3)-p(2))*p(3));
d0 = b0/(-1*p(1)*p(2)*p(3));

y = @(t) d1*exp(p(1)*t) + d2*exp(p(2)*t) + d3*exp(p(3)*t) + d0;
plot(t,y(t),'r-')
