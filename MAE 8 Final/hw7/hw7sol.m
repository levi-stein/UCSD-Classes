clear all; close all; clc;
name = 'AAAA AAAA';
id = 'A00000000';
hw_num = 7;
format long; 

%% Problem 1: (a,b) 4 pts each, (c-f) 3 pts each, total 20 points
load('matA.mat');
sp1a = 0;
for n = 1:size(matA,1)
    for m = 1:size(matA,2)
        if m == n
            continue
        else
            sp1a = sp1a + matA(n,m);
        end
    end
end

sp1b = 0;
for m = 1:size(matA,2)
    for n = 1:size(matA,1)
        if m == n           
            break;
        end
        sp1b = sp1b + matA(n,m);
    end
end

sum_tmp = 0;
for n = 1:size(matA,1)
    for m = 1:size(matA,2)
        sum_tmp = sum_tmp + matA(n,m);
        if sum_tmp > 55
           sp1c = n;
           sp1d = m;
           break;
        end
    end
    if sum_tmp > 55
       break;
    end
end


for m = 1:size(matA,2)
    for n = 1:size(matA,1)
        if matA(n,m) > 10
            if isprime(matA(n,m))
                sp1e = n;
                sp1f = m;
                break
            end
        end
    end
    if matA(n,m) > 10
        if isprime(matA(n,m))
            break
        end
    end
end


%% Problem 2: (a-g) 3 pts each (h)  9 pts, total 30 pts
sp2a = evalc('help car');
[sp2b, sp2c, sp2d] = car(60,10);
[sp2e, sp2f, sp2g] = car(60,1);

figure(1);
subplot(2,1,1);
hold on;
plot(sp2b,sp2c/1000,'ro','MarkerFacecolor','r','MarkerSize',4);
plot(sp2e,sp2f/1000,'bd','MarkerFacecolor','b','MarkerSize',4);
axis tight; box on; grid on;
ylabel('Distance (km)'); axis tight; title('Motion of the car');
set(gca,'FontSize',14);

subplot(2,1,2); hold on;
plot(sp2b,sp2d,'ro','MarkerFacecolor','r','MarkerSize',4);
plot(sp2e,sp2g,'bd','MarkerFacecolor','b','MarkerSize',4);
axis tight; box on; grid on;
xlabel('time (s)'); ylabel('Velocity (m/s)');
legend('dt = 10 s', 'dt = 1 s','Location','best')
set(gca,'FontSize',14);
sp2h = 'See figure 1';


%% Problem 3: (a) 3 pts, (b,c) 7 pts each, (d) 10 pts, total 27 pts
sp3a = evalc('help rocket');

[T, Z, W] = rocket(9400,0.1);
sp3b = Z; 
sp3c = W;

figure(2);
subplot(2,1,1);
plot(T,Z/1000,'r-','LineWidth',4);  
ylabel('Altitude (km)'); 
box on; grid on;
title('Projectile of the rocket'); 
axis([0 70 0 10]);
set(gca,'FontSize',12);

subplot(2,1,2);
plot(T,W,'r-','LineWidth',4); 
xlabel('time (s)');
ylabel('Velocity (m/s)');
box on; grid on;
axis([0 70 0 400]);
set(gca,'FontSize',12);
sp3d = 'See figure 2';

%% Problem 4: (a-f) 3 pts each, (g) 5 pts, total 23 pts
load('stringB.mat');
period_ind = strfind(stringB,'.');
sp4a = numel(period_ind);
sp4b = strrep(stringB,'.','\');
sp4c = stringB(1:period_ind(2));

ind_upper = find(upper(sp4c) == sp4c);
ind_lower = find(lower(sp4c) == sp4c);
sp4d = sp4c;
sp4d(ind_upper) = lower(sp4c(ind_upper));
sp4d(ind_lower) = upper(sp4c(ind_lower));
[sp4e, sp4f] = strtok(sp4c,'.');
sp4e = strtrim(sp4e);
sp4f(1) = []; sp4f(end) = [];
sp4f = strtrim(sp4f);

rest = stringB;
counter = 0;
while ~isempty(rest)
    [A, rest] = strtok(rest);
    if ~isempty(str2num(A))
        counter = counter + 1;
        sp4g(counter) = str2num(A);
    end
    rest = strtrim(rest);
end