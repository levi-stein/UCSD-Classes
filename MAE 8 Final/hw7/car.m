function [T,X,U] = car(Tf,dt)
%CAR This function numerically solves for the motion of the car. Taking two
%inputs Tf = Total Travel Time (s) and dt = time step (s). The output gives
%T = time vector, X = Distance Vector, U = Velocity Vector
% Call Format: [T,X,U] = car(Tf,dt)
T = 0:dt:Tf;
U(1) = 0;
X(1) = 0;
for i = 2:length(T)
    U(i) = U(i-1) + sqrt(0.5*T(i-1))*(sech(T(i-1)/20)^2)*dt;
    X(i) = X(i-1) + U(i-1)*dt;
end
end