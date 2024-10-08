function [y_foh] = foh_sinewave(omega,h,deltat,int);
% Takes a target omega, timestep h and continuous "step" deltat over the
% interval [int] and returns the first order hold y_foh as well as graphs
% it. 
% TEST: foh_sinewave(pi,0.1,0.001,[0 5])
close all;
y = @(t) sin(omega*t);
t = linspace(int(1),int(end),((int(end)/deltat)+1));
plot(t,y(t),'r-');
hold on;
% h = 0.1;
tk = int(1):h:int(end);
plot(tk,y(tk),'kx');
k = 1;
for n = 1:length(t)
    if k*h <= t(n) && t(n) > (k + 1)*h
        k = k + 1;
    end
    y_foh(n)=y(k*h) + (t(n) - h*k)*(y(k*h) - y((k-1)*h))/h;
end
plot(t,y_foh,'b-');
title('First Order Hold of a Sinewave');
legend('sin(omega*t)','sampled y_k','yfoh');
xlabel('time (s)'); ylabel('y');

end

