function [y_zoh] = zoh_sinewave(omega,h,deltat,int)
% Takes a target omega, timestep h and continuous "step" deltat over the
% interval [int] and returns the zero order hold y_zoh as well as graphs
% it. 
% TEST: zoh_sinewave(pi,0.1,0.001,[0 5])
close all;
y = @(t) sin(omega*t);
t = linspace(int(1),int(end),((int(end)/deltat)+1));
plot(t,y(t),'r-');
hold on;
% h = 0.1;
tk = linspace(int(1),int(end),((int(end)/h)+1));
plot(tk,y(tk),'kx');
k = 0;
for n = 1:length(t)
    if k*h <= t(n) && t(n) > (k + 1)*h
        k = k + 1;
    end
    y_zoh(n) = y(k*h);
end
plot(t,y_zoh,'b-');
title('Zero Order Hold of a Sinewave');
legend('sin(omega*t)','sampled y_k','yzoh');
xlabel('time (s)'); ylabel('y');
end