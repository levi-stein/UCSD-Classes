function [T,Z,W] = rocket(Zf,dt)
%ROCKET Determines the projectile motion of a rocket given two inputs, Zf =
%target final altitude, and dt = time step. The trajectory is foud by
%approximation using Euler-Cromer method. The result will give output
%vectors T = time, Z = altitude, and W = velocity.
%Call Format: [T,Z,W] = rocket(Zf,dt)
n = 1;
T(n) = 0;
W(n) = 0;
Z(n) = 0;
mass = 10;

while Z(n) <= Zf
    T(n+1) = T(n) + dt;
    W(n+1) = W(n)+(-gravity(Z(n))+(thrust(T(n))/mass))*dt;
    Z(n+1) = Z(n)+W(n+1)*dt;
    n = n + 1;
end
end

function [g] = gravity(z)
if z < 10000
    g = 9.81*(1-(z/10000)^3);
else
    g = 0;
end
end

function [Th] = thrust(t)
if (0<=t) && (t<2)
    Th = 670;
elseif (2<=t) && (t<4)
    Th = 1360;
else
    Th = 0;
end
end