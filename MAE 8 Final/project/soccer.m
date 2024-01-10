function [T,X,Y,Z,U,V,W] = soccer(X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ)
%SOCCER Takes nine input values (X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ)
%obtained from read_input.m and returns 7 vectors T,X,Y,Z,U,V,W
%corresponding to X,Y,Z position and their respective velocities U,V,W all
%according to time vector T. Using bounds set by field.mat and goal.mat we
%terminate the balls trajectory when exceeding the bounds.
%Call Format: [T,X,Y,Z,U,V,W] = soccer(X0,Y0,Z0,Umag0,theta,phi,omgX,omgY,omgZ)
m = 0.4; % mass
r = 0.11; % radius of ball
A = pi*r^2; % cross-sectional area of ball
rho = 1.2; % density of ball
g = 9.81; % gravity
C_d = 0.3; % drag coefficient of ball
C_m = 0.6; % magnus coefficient of ball
var1 = (rho*A)/(2*m);
dt = 1/100;
% Initalize
n = 1;
T(n) = 0;
X(n) = X0;
Y(n) = Y0;
Z(n) = Z0;
U(n) = Umag0*cosd(theta)*sind(phi);
V(n) = Umag0*sind(theta)*sind(phi);
W(n) = Umag0*cosd(phi);
load('goal.mat');
load('field.mat');
while true
    U(n+1) = U(n) - (C_d*var1*U(n)*sqrt((U(n)^2)+(V(n)^2)+(W(n)^2))...
        -C_m*var1*r*(omgY*W(n)-omgZ*V(n)))*dt;
    V(n+1) = V(n) - (C_d*var1*V(n)*sqrt((U(n)^2)+(V(n)^2)+(W(n)^2))...
        -C_m*var1*r*(omgZ*U(n)-omgX*W(n)))*dt;
    W(n+1) = W(n) - (C_d*var1*W(n)*sqrt((U(n)^2)+(V(n)^2)+(W(n)^2))...
        -C_m*var1*r*(omgX*V(n)-omgY*U(n))+g)*dt;
    T(n+1) = T(n) + dt;
    X(n+1) = X(n) + U(n+1)*dt;
    Y(n+1) = Y(n) + V(n+1)*dt;
    Z(n+1) = Z(n) + W(n+1)*dt;
    for m = 1:5
        [Dx,Dy,Dz] = defender(m,T(n+1));
        dist_t_d(m) = min(min(sqrt((Dx-X(n+1)).^2+(Dy-Y(n+1)).^2+(Dz-Z(n+1)).^2)));
    end
    if Z(n+1) <= r
        break
    elseif X(n+1) >= min(goal.Xpost)-r && X(n+1) <= min(goal.Xpost)+r && Y(n+1) >= max(field.Y)-r
        break
    elseif X(n+1) >= max(goal.Xpost)-r && X(n+1) <= max(goal.Xpost)+r && Y(n+1) >= max(field.Y)-r
        break
    elseif X(n+1)<= min(field.X)+r || X(n+1) >= max(field.X)-r
        break
    elseif Y(n+1) <= min(field.Y)+r || Y(n+1) >= max(goal.Ynet)-r
        break
    elseif Y(n+1) >= max(field.Y)-r
        if X(n+1) <= min(goal.Xnet)+r || X(n+1) >= max(goal.Xnet)-r || Z(n+1) >= max(goal.Znet)-r || Z(n+1) <= r
            break
        end
    elseif dist_t_d(1) <= r
        break
    elseif dist_t_d(2) <= r
        break
    elseif dist_t_d(3) <= r
        break
    elseif dist_t_d(4) <= r
        break
    elseif dist_t_d(5) <= r
        break
    end
    n = n + 1;
end
end % function