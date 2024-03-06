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
tk = linspace(int(1),int(end),((int(end)/h)+1));
plot(tk,y(tk),'kx');
k = 0;
for n = 1:length(t)
    if k*h <= t(n) && t(n) > (k + 1)*h
        k = k + 1;
    end
    y_soh(n)=y(k*h) + (t(n) - h*k)*(y(k*h) - y((k-1)*h))/h + (t(n) - h*k)*(t(n) - h*(k-1))*(y(k*h) - y((k-1)*h))*(y(k*h) - y((k-2)*h))/(h*(h*(k-1) - h*(k-2))); 
end
plot(t,y_soh,'b-');
title('Second Order Hold of a Sinewave');
legend('sin(omega*t)','sampled y_k','ysoh');
xlabel('time (s)'); ylabel('y');

end
