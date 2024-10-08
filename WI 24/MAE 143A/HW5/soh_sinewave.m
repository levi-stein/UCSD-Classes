function [y_soh] = soh_sinewave(omega,h,deltat,int);
% Takes a target omega, timestep h and continuous "step" deltat over the
% interval [int] and returns the second order hold y_foh as well as graphs
% it. 
% TEST: soh_sinewave(pi,0.1,0.001,[0 5])
close all;
y = @(t) sin(omega*t);
t = linspace(int(1),int(end),((int(end)/deltat)+1));
plot(t,y(t),'r-');
hold on;
% h = 0.1;
tk = int(1):h:int(end);
plot(tk,y(tk),'kx');
k = 2;
for n = 1:length(t)
    if k*h <= t(n) && t(n) > (k + 1)*h
        k = k + 1;
    end
    y_soh(n)= y((k-2)*h)*((t(n) - h*(k-1))*(t(n) - h*k))/((h*(k-2) - h*(k-1))*(h*(k-2) - h*k))...
        + y((k-1)*h)*((t(n) - h*(k-2))*(t(n) - h*k))/((h*(k-1) - h*(k-2))*(h*(k-1) - h*k))...
        + y(k*h)*((t(n) - h*(k-2))*(t(n) - h*(k-1)))/((h*(k) - h*(k-2))*(h*(k) - h*(k-1))); 
end
plot(t,y_soh,'b-');
title('Second Order Hold of a Sinewave');
legend('sin(omega*t)','sampled y_k','ysoh');
xlabel('time (s)'); ylabel('y');

end