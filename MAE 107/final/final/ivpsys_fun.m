function yp = ivpsys_fun(t, y)
% IVPSYS_FUN evaluates the right-hand-side of the ODE's.
% Inputs are current time and current values of y's. 
% y's include the water depth w in y(1) and exit velocity u in y(2).
% Outputs are values of yprime's. The function calls colebrook to evaluate f
% The function calls clamped_cubic_spline to evaluate precipitation at a smaller timestep.
% Call format: yp = ivpsys_fun(t, y)

global d1 d2 l r kappa g nu time_rain precipitation


%% Get friction factor
Re = y(2)*d2/nu;
f = colebrook(r,Re);

%% Get precipitation
% load('rain_data.mat'); % Should i be using newstep?
% newstep = [0:0.3:900];
% for i = 1:length(newstep)
S = clamped_cubic_spline(time_rain,precipitation,0,0,t);


%% Obtain yp
yp(1) = (-1*(d2^2)/(d1^2))*y(2) + S;
yp(2) = ((g*y(1)/l) - (1 + kappa + f*l/d2)*(y(2)^2)/(2*l));
end % function ivpsys_fun