function [T,X,Y,Z,U,V,W] = tennis_trajectory(X0,Y0,Z0,U0,V0,W0)
%UNTITLED2 Summary of this function goes here
%Call format: [T,X,Y,Z,U,V,W] = tennis_trajectory(X0,Y0,Z0,U0,V0,W0)

g = 9.81;
dt = 0.01;
n = 1;
T(n) = 0;
X(n) = X0;
Y(n) = Y0;
Z(n) = Z0;
U(n) = U0;
V(n) = V0;
W(n) = W0;

while Z(n) > 0
    T(n+1) = T(n) + dt;
    U(n+1) = U(n);
    V(n+1) = V(n);
    W(n+1) = W(n) - g*dt;
    X(n+1) = X(n) + U(n)*dt;
    Y(n+1) = Y(n) + V(n)*dt;
    Z(n+1) = Z(n) + W(n)*dt;
    n = n + 1;
end





end