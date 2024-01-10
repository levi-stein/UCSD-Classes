function [alpha, beta, fun] = best_fit_power_model(xbar,ybar)
% BEST_FIT_POWER_MODEL fits a power model in the form: 
% ybar = alpha*xbar^beta. Function returns alpha and beta
% and anonymous function of the fit.
% Call format: [alpha, beta, fun] = best_fit_power_model(xbar,ybar)

%% Transform variables
xi = log10(xbar);
yi = log10(ybar);

%% Least squares for linear model
n = length(xi);
sumx = sum(xi);
sumy = sum(yi);
sumx2 = sum(xi.^2);
sumxy = sum(xi.*yi);
m = (n*sumxy - sumx*sumy)/(n*sumx2 - sumx^2);
b = (sumx2*sumy - sumx*sumxy)/(n*sumx2 - sumx^2);

%% Transform back to power model
alpha = 10^b;
beta = m;
fun = @(x) alpha*x.^beta;

end % function best_fit_power_model