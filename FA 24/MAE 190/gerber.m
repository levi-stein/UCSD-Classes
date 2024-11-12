function d = gerber(Tm,Ta,Mm,Ma,AISI,ka,ke,n,Dd,rd)
% Dynamic loading function for shaft design using DE-Gerber failure theory
% function takes inputs Tm (midrange torque), Ta (alternating torque), Mm
% (midrange moment), Ma (alternating moment), AISI number for material
% properties, n (safety factor), Dd (D/d ratio), and rd (r/d ratio can
% only be 0.02, or 0.1)
% function returns converged value for estimated diameter

%% first iteration
if rd == 0.02
    Kt = 2.7;
    Kts = 2.2;
elseif rd == 0.1
    Kt = 1.7;
    Kts = 1.5;
end
if AISI



































end

