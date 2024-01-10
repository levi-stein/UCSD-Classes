clear all; close all; clc; format long; format compact;

%% Student name, ID number, and homework_number are required
name = 'Levi Stein';
id = 'A16791467';
hw_num = 'final';

%% Set up physical parameters

global d1 d2 l r kappa g nu rho time_rain precipitation

% Load precipitation which has time_rain and precipitation
load('rain_data.mat'); 

% Drainage system parameters:
d1 = 2;                % tank diameter in meter
d2 = 0.05;             % pipe diameter in meter
l = 0.5;               % pipe length in meter
r = 0.0001;            % pipe roughness ratio (unitless)
kappa = 1.5;           % head loss due to pipe entrance and exit (unitless)

% Water property:
g = 9.81;              % gravity in meter per squared second
nu = 1e-6;             % kinematic vicosity of water in squared meter per second)
rho = 1000;            % density of water in kg per cubic meter

%% Solve IVP:
w0 = 0.5;           % initial water depth in the tank
u0 = 1.9;           % initial velocity at pipe exit
h = 0.3;            % time step in second
tspan = [0 900];        % time span in second

[t, y] = ivpsys_RKM([w0 u0], h, tspan);
w = y(:,1);          % extract depth from matrix y
u = y(:,2);          % extract velocity from matrix y


%% Analyis 1: Plotting  depth w and velocity u and dw/dt
dwdt = zeros(1,length(t));
dwdt(1) = ((-3/2)*w(1) + 2*w(2) - (1/2)*w(3))/h;
dwdt(end) = ((1/2)*w(end-2) - 2*w(end-1) + (3/2)*w(end))/h;
for i = 2:length(t)-1
    dwdt(i) = (w(i+1) - w(i-1))/(2*h);
end

figure(1);

% Top panel: depth vs time
subplot(3,1,1);
plot(t,w,'k');
xlabel('time t (s)');
ylabel('depth w (m)');
title('water depth vs time')
box on; grid on; set(gca,'FontSize',12);

% Middle panel: velocity vs time
subplot(3,1,2);
plot(t,u,'k');
xlabel('time t (s)');
ylabel('velocity u (m/s)');
title('exit velocity vs time')
box on; grid on; set(gca,'FontSize',12);

% Bottom panel: time rate of change in depth vs time
subplot(3,1,3);
plot(t,dwdt,'k','LineWidth',1);
xlabel('time t (s)');
ylabel('dw/dt (m/s)');
title('time rate of change in depth vs time')
box on; grid on; set(gca,'FontSize',12);

p1a = 'See figure 1';
p1b = dwdt(1);
p1c = dwdt(2);
p1d = dwdt(end);

%% Analysis 2: Solve Colebrook eqn for friction factor 
Re = u*d2/nu;
for n = 1:length(Re)
    friction_factor(n) = colebrook(r,Re(n));
end

figure(2);
plot(Re,friction_factor,'-*');
xlabel('Reynolds number Re'); ylabel('friction factor f'); 
title('Frictional factor for turbulent flows in pipe from Colebrook equation');
box on; grid on; set(gca,'FontSize',12);

p2a = 'See figure 2';

%% Analysis 3: power model fit to predict velocity for given depth range

[alpha, beta, fun] = best_fit_power_model(w,u);

figure(3); hold on;
plot(w,u,'k*');
depth_range = 0.05:0.05:1;
plot(depth_range,fun(depth_range),'-r');
xlabel('water depth (m)'); 
ylabel('velocity (m/s)');
legend('simulation result','power model result');
title('Power model fit for velocity as a function of water depth');
box on; grid on; set(gca,'FontSize',12);

p3a = 'See figure 3';
p3b = alpha;
p3c = beta;

%%  Analysis 4: Mass conservation
% Get the rain rate that goes into the simulation
for n = 1:length(t)
    S(n) = clamped_cubic_spline(time_rain,precipitation,0,0,t(n));
end

m_change = ((pi*rho*(d1^2))/4)*(w(end)-w(1));

rainterm2 = sum(S(2:2:end-1));
rainterm3 = sum(S(3:2:end-2));

m_rain = ((pi*rho*(d1^2))/4)*((h/3)*(S(1) + 4*rainterm2 + 2*rainterm3 + S(end)));

outterm2 = sum(u(2:2:end-1));
outterm3 = sum(u(3:2:end-2));

m_out = (-1*(pi*rho*(d2^2))/4)*((h/3)*(u(1) + 4*outterm2 + 2*outterm3 + u(end)));

p4a = m_change;
p4b = m_rain;
p4c = m_out;
p4d = m_change - m_rain - m_out;