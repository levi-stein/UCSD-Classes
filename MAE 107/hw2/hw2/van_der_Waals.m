function [vn] = van_der_Waals(P, T)
% VAN_DER_WAALS returns the specific volume (m^3/kg) of water vapor 
% for a given pressure P (Pa) and temperature (K). The function solves
% for the root of the nonlinear van der Waals equations using Newton's
% method:
%   f(v) = P*v^3 - (P*b + RT)*v^2 + a*v - a*b,
% where R, a, b are given contants.
% The tolerance is set at 10^-6 and a maximum of 25 iterations are
% used to terminate the iteration.
% Call format: [vn] = van_der_Waals(P, T)


%% Set up physical parameters:
R = 461.495;
a = 1703.28;
b = 0.00169099;
%% Set up parameters for Newton's method:
max_iter = 25;
tol = 1e-6;

%% Define function f(v) and its derivative fp = df/fv
% f = @(v) P*v^3 - (P*b + R*T)*v^2 + a*v - a*b;
% fp = @(v) 3*P*v^2 - 2*(P*b + R*T)*v + a;

%% Define initial guess
n = 1;
vn = R*T/P;
eps = 1;
%% Execute Newton's method:
while (n < max_iter) && (eps >= tol)
f = @(v) P*v^3 - (P*b + R*T)*v^2 + a*v - a*b;
fp = @(v) 3*P*v^2 - 2*(P*b + R*T)*v + a;
vn1 = vn - f(vn)/fp(vn);
eps = abs(vn1 - vn);
vn = vn1;
n = n + 1;
end

% Consider displaying the following message when n > max_iter:
% fprintf('Warning: Newton''s method did not converge within %d interations', max_iter);

end %function van_der_Waals