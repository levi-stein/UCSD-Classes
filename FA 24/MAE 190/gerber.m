function [d] = gerber(Tm,Ta,Mm,Ma,AISI,a,e,n,Dd)
% Dynamic loading function for steel HR or CD shaft design using DE-Gerber failure theory
% function takes inputs Tm (midrange torque[lb*in]), Ta (alternating torque [lb*in]), Mm
% (midrange moment [lb*in]), Ma (alternating moment [lb*in]), AISI number for material
% properties, a (surface finish:'H' for Hot-rolled or 'C' for Cold-drawn/Machined), e (50,90,95,99,99.9,99.99), n (safety factor), Dd (D/d ratio takes inputs only between 2 and 1.1)
% function returns converged value for estimated diameter [in]
%% preliminary calc

rd = (Dd-1)/2;
rd = round(rd,2);

if AISI == 1006 && a == 'H'
    Sut = 43*10^3;
    Sy = 24*10^3;
elseif AISI == 1006 && a == 'C'
    Sut = 48*10^3;
    Sy = 41*10^3;
elseif AISI == 1010 && a == 'H'
    Sut = 47*10^3;
    Sy = 26*10^3;
elseif AISI == 1010 && a == 'C'
    Sut = 53*10^3;
     Sy = 44*10^3;
elseif AISI == 1015 && a == 'H'
    Sut = 50*10^3;
     Sy = 27.5*10^3;
elseif AISI == 1015 && a == 'C'
    Sut = 56*10^3;
     Sy = 47*10^3;
elseif AISI == 1018 && a == 'H'
    Sut = 58*10^3;
     Sy = 32*10^3;
elseif AISI == 1018 && a == 'C'
    Sut = 64*10^3;
     Sy = 54*10^3;
elseif AISI == 1020 && a == 'H'
    Sut = 55*10^3;
     Sy = 30*10^3;
elseif AISI == 1020 && a == 'C'
    Sut = 68*10^3;
     Sy = 57*10^3;
elseif AISI == 1030 && a == 'H'
    Sut = 68*10^3;
     Sy = 37.5*10^3;
elseif AISI == 1030 && a == 'C'
    Sut = 76*10^3;
     Sy = 64*10^3;
elseif AISI == 1035 && a == 'H'
    Sut = 72*10^3;
     Sy = 39.5*10^3;
elseif AISI == 1035 && a == 'C'
    Sut = 80*10^3;
     Sy = 67*10^3;
elseif AISI == 1040 && a == 'H'
    Sut = 76*10^3;
     Sy = 42*10^3;
elseif AISI == 1040 && a == 'C'
    Sut = 85*10^3;
     Sy = 71*10^3;
elseif AISI == 1045 && a == 'H'
    Sut = 82*10^3;
     Sy = 45*10^3;
elseif AISI == 1045 && a == 'C'
    Sut = 91*10^3;
     Sy = 77*10^3;
elseif AISI == 1050 && a == 'H'
    Sut = 90*10^3;
     Sy = 49.5*10^3;
elseif AISI == 1050 && a == 'C'
    Sut = 100*10^3;
     Sy = 84*10^3;
elseif AISI == 1060 && a == 'H'
    Sut = 98*10^3;
    Sy = 54*10^3;
elseif AISI == 1080 && a == 'H'
    Sut = 112*10^3;
    Sy = 61.5*10^3;
elseif AISI == 1095 && a == 'H'
    Sut = 120*10^3;
    Sy = 66*10^3;
elseif AISI == 9999 && a == 'C'
    Sut = 82*10^3;
    Sy = 58*10^3;
end

%% first iteration

if Mm == 0 && Ma == 0 && (Tm ~= 0 || Ta ~=0)
    kc = 0.59;
else
    kc = 1;
end   


if rd <= 0.02
    Kt1 = 2.7;
    Kts1 = 2.2;
elseif rd >= 0.1
    Kt1 = 1.7;
    Kts1 = 1.5;
end

if a == 'H'
    ka = 14.4*((Sut*10^-3)^(-0.718));
elseif a == 'C'
    ka = 2.7*((Sut*10^-3)^(-0.265));
end

if e == 50
    ke = 1;
elseif e == 90
    ke = 0.897;
elseif e == 95
    ke = 0.868;
elseif e == 99
    ke = 0.814;
elseif e == 99.9
    ke = 0.753;
elseif e == 99.99
    ke = 0.702;
end

Se1 = ka*kc*ke*(0.5*Sut);

A1 = sqrt(4*(Kt1*Ma)^2 + 3*(Kts1*Ta)^2);
B1 = sqrt(4*(Kt1*Mm)^2 + 3*(Kts1*Tm)^2);

d(1) = ((8*n*A1/(pi*Se1))*(1+(1+(2*B1*Se1/(A1*Sut))^2)^(1/2)))^(1/3);

%% 2nd iteration

if Dd == 2
    Kt = 0.90879*(rd)^(-0.28598);
    Kts = 0.86331*(rd)^(-0.23865);
elseif Dd < 2 && Dd > 1.5 % Linear interpolation approximation
    Kt = 0.90879*(0.5)^(-0.28598) + (((0.93836*(0.25)^(-0.25759)) - (0.90879*(0.5)^(-0.28598)))/(0.25 - 0.5))*(rd - 0.5);
    Kts = 0.86331*(0.5)^(-0.23865) + (((0.85*(0.25)^(-0.23)) - (0.86331*(0.5)^(-0.23865)))/(0.25 - 0.5))*(rd - 0.5);
elseif Dd == 1.5
    Kt = 0.93836*(rd)^(-0.25759);
    Kts = 0.85*(rd)^(-0.23);
elseif Dd < 1.5 && Dd > 1.2
    Kt =  0.93836*(0.25)^(-0.25759) + (((0.97098*(0.1)^(-0.21796)) - (0.93836*(0.25)^(-0.25759)))/(0.1 - 0.25))*(rd - 0.25);
    Kts = 0.85*(0.25)^(-0.23) + (((0.83425*(0.1)^(-0.21649)) - (0.85*(0.25)^(-0.23)))/(0.1 - 0.25))*(rd - 0.25);
elseif Dd == 1.2
    Kt = 0.97098*(rd)^(-0.21796);
    Kts = 0.83425*(rd)^(-0.21649);
elseif Dd < 1.2 && Dd> 1.1
    Kt = 0.97098*(0.1)^(-0.21796) + (((0.9512*(0.05)^(-0.23757)) - (0.97098*(0.1)^(-0.21796)))/(0.05 - 0.1))*(rd - 0.1);
    Kts = 0.83425*(0.1)^(-0.21649) + (((0.9*(0.05)^(-0.14)) - (0.83425*(0.1)^(-0.21649)))/(0.05 - 0.1))*(rd - 0.1);
elseif Dd == 1.1
    Kt = 0.9512*(rd)^(-0.23757);
    Kts = 0.9*(rd)^(-0.14);
end

roota = 0.246 - 3.08*(10^-3)*(Sut*10^-3) + 1.51*(10^-5)*(Sut*10^-3)^2 - 2.67*(10^-8)*(Sut*10^-3)^3;
rootas = 0.19 - 2.51*(10^-3)*(Sut*10^-3) + 1.35*(10^-5)*(Sut*10^-3)^2 - 2.67*(10^-8)*(Sut*10^-3)^3;

q1 = 1/(1 + (roota/sqrt(rd*d(1))));
qs1 = 1/(1 + (rootas/sqrt(rd*d(1))));

Kf1 = 1 + q1*(Kt - 1); % need to define Kt and Kts based on Dd and rd
Kfs1 =  1 + qs1*(Kts - 1);

if d(1) >= 0.11 && d(1) <= 2
    kb1 = 0.879*d(1)^(-0.107);
elseif d(1) >= 2 && d(1) <= 10
    kb1 = 0.91*d(1)^(-0.157);
else
    kb1 = 0.85;
end

Se2 = ka*kb1*kc*ke*(0.5*Sut);

A2 = sqrt(4*(Kf1*Ma)^2 + 3*(Kfs1*Ta)^2);
B2 = sqrt(4*(Kf1*Mm)^2 + 3*(Kfs1*Tm)^2);

d(2) = ((8*n*A2/(pi*Se2))*(1+(1+(2*B2*Se2/(A2*Sut))^2)^(1/2)))^(1/3);
%% Final iterations
i = 1;
q(i) = q1;
qs(i) = qs1;
Kf(i) = Kf1;
Kfs(i) =  Kfs1;
while abs((d(i+1)-d(i))/d(i+1)) > 0.01
    q(i) = 1/(1 + (roota/sqrt(rd*d(i+1))));
    qs(i) = 1/(1 + (rootas/sqrt(rd*d(i+1))));
    Kf(i) = 1 + q(i)*(Kt - 1);
    Kfs(i) =  1 + qs(i)*(Kts - 1);

    if d(i+1) >= 0.11 && d(i+1) <= 2
        kb(i) = 0.879*d(i+1)^(-0.107);
    elseif d(i+1) >= 2 && d(i+1) <= 10
        kb(i) = 0.91*d(i+1)^(-0.157);
    else
        kb(i) = 0.85;
    end

    Se(i) = ka*kb(i)*kc*ke*(0.5*Sut);
    A(i) = sqrt(4*(Kf(i)*Ma)^2 + 3*(Kfs(i)*Ta)^2);
    B(i) = sqrt(4*(Kf(i)*Mm)^2 + 3*(Kfs(i)*Tm)^2);
    d(i+2) = ((8*n*A(i)/(pi*Se(i)))*(1+(1+(2*B(i)*Se(i)/(A(i)*Sut))^2)^(1/2)))^(1/3);
    i = i+1;
end

siga_p = sqrt(((32*Kf(end)*Ma)/(pi*(d(end)^3)))^2 + 3*((16*Kfs(end)*Ta)/(pi*(d(end)^3)))^2);
sigm_p = sqrt(((32*Kf(end)*Mm)/(pi*(d(end)^3)))^2 + 3*((16*Kfs(end)*Tm)/(pi*(d(end)^3)))^2);
sigmax_p = sigm_p + siga_p;

yield = Sy/sigmax_p;

if yield <= 1
    disp('Yields at first cycle');
    disp(yield);
else
    disp('Does not yield at first cycle');
    disp(yield);
end

end

