function d = gerber(Tm,Ta,Mm,Ma,AISI,a,e,n,Dd,rd)
% Dynamic loading function for steel HR or CD shaft design using DE-Gerber failure theory
% function takes inputs Tm (midrange torque[N*m]), Ta (alternating torque[N*m]), Mm
% (midrange moment[N*m]), Ma (alternating moment [N*m]), AISI number for material
% properties, a ('HR' or 'CD'), e (99,99.9,99.99), n (safety factor), Dd (D/d ratio), and rd (r/d ratio can
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

d(1) = ((8*n*A1/(pi*Se1))*(1+(1+(2*B1*Se1/(A1*Sut))^2)^(1/2)))^(1/3);

%% 2nd and further iterations

roota = 0.246 - 3.08*(10^-3)*Sut + 1.51*(10^-5)*Sut^2 -2.67*(10^-8)*Sut^3;
rootas = 0.19 - 2.51*(10^-3)*Sut + 1.35*(10^-5)*Sut^2 -2.67*(10^-8)*Sut^3;

q1 = 1/(1 + (roota/sqrt(rd*d(1))));
qs1 = 1/(1 + (rootas/sqrt(rd*d(1))));

Kf1 = 1 + q1*(Kt - 1); % need to define Kt and Kts based on Dd and rd
Kfs1 =  1 + qs1*(Kts - 1);

if d(1)*10^3 >= 2.79 && d(1)*10^3 <= 51
    kb1 = 1.24*d(1)^(-0.107);
elseif d(1)*10^3 >= 51 && d(1)*10^3 <= 254
    kb1 = 1.51*d(1)^(-0.157);
else
    kb1 = 1;
end

Se2 = ka*kb1*ke*(0.5*Sut);

A2 = sqrt(4*(Kf1*Ma)^2 + 3*(Kfs1*Ta)^2);
B2 = sqrt(4*(Kf1*Mm)^2 + 3*(Kfs1*Tm)^2);

d(2) = ((8*n*A2/(pi*Se2))*(1+(1+(2*B2*Se2/(A2*Sut))^2)^(1/2)))^(1/3);

i = 1;
while abs((d(i+1)-d(i))/d(i+1)) > 0.01
    q(i) = 1/(1 + (roota/sqrt(rd*d(i+1))));
    qs(i) = 1/(1 + (rootas/sqrt(rd*d(i+1))));
    Kf(i) = 1 + q(i)*(Kt - 1);
    Kfs(i) =  1 + qs(i)*(Kts - 1);

    if d(i+1)*10^3 >= 2.79 && d(i+1)*10^3 <= 51
        kb(i) = 1.24*d(i+1)^(-0.107);
    elseif d(i+1)*10^3 >= 51 && d(i+1)*10^3 <= 254
        kb(i) = 1.51*d(i+1)^(-0.157);
    else
        kb(i) = 1;
    end

    Se(i) = ka*kb(i)*ke*(0.5*Sut);
    A(i) = sqrt(4*(Kf(i)*Ma)^2 + 3*(Kfs(i)*Ta)^2);
    B(i) = sqrt(4*(Kf(i)*Mm)^2 + 3*(Kfs(i)*Tm)^2);
    d(i+2) = ((8*n*A(i)/(pi*Se(i)))*(1+(1+(2*B(i)*Se(i)/(A(i)*Sut))^2)^(1/2)))^(1/3);
    i = i+1;
end

d = d(end);

end

