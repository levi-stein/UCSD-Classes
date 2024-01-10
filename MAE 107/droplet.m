
clear all; clc; close all;

g = 9.81; %m/s^2 (gravitational acceleration)

%RHS of ODE
f = @(t,v) g - fd(t,v); %ODE: v' = f(t,v(t)).

v0 = 0; %initial condition
t0 = 0; %s (start time)
tf = 1; %s (end time)

%MATLAB's ode45 solution
tspan = [t0 tf];
[t,v] = ode45(f, tspan, v0);

%Plot of MATLAB's ode45 solution
figure(1)
hold on
plot(t,v,'k-','LineWidth',2) 
xlabel('t (s)')
ylabel('v (m/s)')

%Euler method
h = 0.05; %step size
t = t0:h:tf;
n = length(t);
v = zeros(1,n);
v(1) = v0;
for i = 1:n-1
    v(i+1) = v(i) + f(t(i),v(i))*h;
end

%Plot of Euler solution
figure(1)
plot(t,v,'b-','LineWidth',2) %Euler

%Predictor-corrector method
h = 0.05; %step size
t = t0:h:tf; %grid points
n = length(t); %number of grid points
v = zeros(1,n); %preallocation of velocity array
v(1) = v0; %initial velocity
for i=1:2 %velocities at next two grid points obtained using a RK3 method
    k1 = f(t(i),v(i));
    k2 = f(t(i)+h/2,v(i)+k1*h/2);
    k3 = f(t(i)+h,v(i)-k1*h+2*k2*h);
    v(i+1) = v(i) + 1/6*(k1 + 4*k2 + k3)*h;
end
for i = 3:n-1 %all subsequent velocities obtained using AB3-AM2 predictor-corrector method
    v(i+1) = v(i) + (5/12*f(t(i-2),v(i-2)) - 4/3*f(t(i-1),v(i-1)) + 23/12*f(t(i),v(i)))*h;
    for j = 1:10 %iterating AM2
        v(i+1) = v(i) + (-1/12*f(t(i-1),v(i-1)) + 2/3*f(t(i),v(i)) + 5/12*f(t(i+1),v(i+1)))*h;
    end
end
figure(1)
plot(t,v,'m:','LineWidth',2) %predictor-corrector method
legend('ode45', 'Euler','AB3-AM2')


function fd = fd(t,v)

rho_water = 997; %kg/m^3
rho_air = 1.225; %kg/m^3
nu_air = 1.516e-5; %m^2/s
R0 = 1e-4; %m
tau = 4.3; %s
R = @(t) R0*sqrt(1-t/tau); %radius of droplet
Re = 2*R(t)*abs(v)/nu_air; %Raynolds number

if Re >= 0 && Re <= 1e3
    cdv2 = 12*nu_air/R(t)*v + 3*(nu_air/(2*R(t)))^0.28*v^(2-0.28);
elseif Re > 1e3 && Re <= 3e5
    cdv2 = 0.458*v^2;
elseif Re > 3e5 && Re <= 1e6
    cdv2 = 0.1*v^2;
else
    fprintf('Re = %f\n', Re)
end 

fd = 3/8*rho_air/rho_water/R(t)*cdv2;

end