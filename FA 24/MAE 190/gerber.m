function d = gerber(Tm,Ta,Mm,Ma,AISI,a,e,n,Dd,rd)
% Dynamic loading function for steel HR or CD shaft design using DE-Gerber failure theory
% function takes inputs Tm (midrange torque[N*m]), Ta (alternating torque[N*m]), Mm
% (midrange moment[N*m]), Ma (alternating moment [N*m]), AISI number for material
% properties, a (HR or CD), e (99,99.9,99.99), n (safety factor), Dd (D/d ratio), and rd (r/d ratio can
% only be 0.02, or 0.1)
% function returns converged value for estimated diameter
%% preliminary calc

if AISI == 1006 && a == 'HR'
    Sut = 300*10^6;
elseif AISI == 1006 && a == 'CD'
    Sut = 330*10^6;
elseif AISI == 1010 && a == 'HR'
    Sut = 320*10^6;
elseif AISI == 1010 && a == 'CD'
    Sut = 370*10^6;
elseif AISI == 1015 && a == 'HR'
    Sut = 340*10^6;
elseif AISI == 1015 && a == 'CD'
    Sut = 390*10^6;
elseif AISI == 1018 && a == 'HR'
    Sut = 400*10^6;
elseif AISI == 1018 && a == 'CD'
    Sut = 440*10^6;
elseif AISI == 1020 && a == 'HR'
    Sut = 380*10^6;
elseif AISI == 1020 && a == 'CD'
    Sut = 470*10^6;
elseif AISI == 1030 && a == 'HR'
    Sut = 470*10^6;
elseif AISI == 1030 && a == 'CD'
    Sut = 520*10^6;
elseif AISI == 1035 && a == 'HR'
    Sut = 500*10^6;
elseif AISI == 1035 && a == 'CD'
    Sut = 550*10^6;
elseif AISI == 1040 && a == 'HR'
    Sut = 520*10^6;
elseif AISI == 1040 && a == 'CD'
    Sut = 590*10^6;
elseif AISI == 1045 && a == 'HR'
    Sut = 570*10^6;
elseif AISI == 1045 && a == 'CD'
    Sut = 630*10^6;
elseif AISI == 1050 && a == 'HR'
    Sut = 620*10^6;
elseif AISI == 1050 && a == 'CD'
    Sut = 690*10^6;
end

%% first iteration

if rd == 0.02
    Kt1 = 2.7;
    Kts1 = 2.2;
elseif rd == 0.1
    Kt1 = 1.7;
    Kts1 = 1.5;
end

if a == 'HR'
    ka = 57.7*((Sut*10^-6)^(-0.718));
elseif a == 'CD'
    ka = 4.51*((Sut*10^-6)^(-0.265));
end

if e == 99
    ke = 0.814;
elseif e == 99.9
    ke = 0.753;
elseif e == 99.99
    ke = 0.702;
end

Se1 = ka*ke*(0.5*Sut);

A1 = sqrt(4*(Kt1*Ma)^2 + 3*(Kts1*Ta)^2);
B1 = sqrt(4*(Kt1*Mm)^2 + 3*(Kts1*Tm)^2);

d1 = ((8*n*A1/(pi*Se1))(1+(1+(2*B1*Se1/(A1*Sut))^2)^(1/2)))^(1/3);

%% further iterations


































end

