function [t, y] = ivpsys_RKM(y0, h, tspan)
% ivps_Runge_Kutta_Merson solves system ofIVP using Runge-Kutta-Merson 
% method: y' = f(t,y) with the IC y(t = 0) = y0 and a time step h over a
% time period tspan. The function calls ivpsys_fun to evaluate  f(t,y). 
% Outputs are time vector t and the solution matrix y.
% Call format: [t, y] = ivpsys_RKM(y0, h, tspan)


%% Set up parameters and initial conditions
N = ceil((tspan(2)-tspan(1))/h);
num_eq = length(y0);
t = zeros(N+1,1);
y = zeros(N+1,num_eq);
t(1) = tspan(1);
y(1,:) = y0;

%% Setup RK coefficients: c's, p's and q's
c1 = 1/6;  
c2 = 0;
c3 = 0;
c4 = 4/6;
c5 = 1/6;
 
p1 = 1/3;   
p2 = 1/3;
p3 = 1/2;
p4 = 1;

q11 = 1/3; 
q21 = 1/6;
q22 = 1/6;
q31 = 1/8;
q32 = 0;
q33 = 3/8;
q41 = 1/2;
q42 = 0;
q43 = -3/2;
q44 = 2;

%% Time advancement:
for n = 1:N
    % RK 1st substep
    k1 = h*ivpsys_fun(t(n),y(n,:));
    
    % RK 2nd substep
    k2 = h*ivpsys_fun(t(n) + p1*h,y(n,:) + q11*k1);
    
    % RK 3rd substep
    k3 = h*ivpsys_fun(t(n) + p2*h,y(n,:) + q21*k1 + q22*k2);
    
    % RK 4th substep
    k4 = h*ivpsys_fun(t(n) + p3*h,y(n,:) + q31*k1 + q33*k3);
    
    % RK 5th substep
    k5 = h*ivpsys_fun(t(n) + p4*h,y(n,:) + q41*k1 + q43*k3 + q44*k4);
    
    % Advance from tn to tn+h using k1 through k5
    y(n+1,:) = y(n,:) + (c1*k1 + c4*k4 +c5*k5);
         
    % Update time
    t(n+1) = t(n) + h;
    
end

end % function ivpsys_RKM