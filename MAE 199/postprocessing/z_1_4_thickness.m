clear all; close all; clc;
pointsx = [0 7 14 21 28];
pointsy = [0 4 8 12];
data = importdata('khi12.txt');
t = 0:1:150;
np = 20;
for n = 1:20
    for m = 0:150
        ux(n,m+1) = data((n + m*np),2);
        uy(n,m+1) = data((n + m*np),3);
        p(n,m+1) = data((n + m*np),4);
        vort(n,m+1) = data((n + m*np),5);
    end
end

yo = 1.4722;
val = 0.9;


for i = 1:151
    ux_4 = ux(6,i);
    if ux_4 <= val
        t_4 = t(i);
        break
    end
end

for i = 1:151
    ux_8 = ux(11,i);
    if ux_8 <= val
        t_8 = t(i);
        break
    end
end

for i = 1:151
    ux_12 = ux(16,i);
    if ux_12 <= val
        t_12 = t(i);
        break
    end
end

tnew = [0 t_4 t_8 t_12];
y90 = [yo 4 8 12];

plot(tnew,y90,'r');

for i = 1:151
    umean(i) = (ux(1,i) + ux(6,i) + ux(11,i) + ux(16,i))/4;
end




