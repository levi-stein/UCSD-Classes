clear all; close all; clc;
pointsx = [0 6 12 18 24 30];
pointsx1 = [0 15 30 45 60 75];
pointsy = [0 0 0 0 0 0];
np = length(pointsx);
data = importdata('khi11.txt');
t = 0:1:150;
grt = 0.09485;
% ux = data(:,2);
% uy = data(:,3);
% uz = data(:,4);
% vort = data(:,5);
for n = 1:6
    for m = 0:150
        ux(n,m+1) = data((n + m*np),2);
        uy(n,m+1) = data((n + m*np),3);
        p(n,m+1) = data((n + m*np),4);
        vort(n,m+1) = data((n + m*np),5);
    end
end

vorto = -sech(0)^2;
delvort = vort - vorto;

omegat = log(delvort);
for n = 1:6
    gr(n,:) = diff(log(delvort(n,:)));
end

data1 = importdata('khi14.txt');
t = 0:1:150;
% ux = data(:,2);
% uy = data(:,3);
% uz = data(:,4);
% vort = data(:,5);
for n = 1:6
    for m = 0:150
        ux1(n,m+1) = data1((n + m*np),2);
        uy1(n,m+1) = data1((n + m*np),3);
        p1(n,m+1) = data1((n + m*np),4);
        vort1(n,m+1) = data1((n + m*np),5);
    end
end

vorto = -sech(0)^2;
delvort1 = vort1 - vorto;

omegat1 = log(delvort1);
for n = 1:6
    grd(n,:) = diff(log(delvort1(n,:)));
end
%% Plot data
% vorticity
figure(1)
subplot(2,3,1)
hold on
plot(t,vort(1,:),'r-');
%plot(t,log(delvort(1,:)),'b');
xlabel('time [units]');
ylabel('vorticity');
title('Vorticity vs. Time for x=0, y=0');
grid on;
plot(t,vort1(1,:),'b-');
legend('No stress','Dirchlet','Location','best');
hold off;

subplot(2,3,2)
hold on
plot(t,vort(2,:),'r-');
%plot(t,log(delvort(2,:)),'b');
xlabel('time [units]');
ylabel('vorticity');
title('Vorticity vs. Time for x=6, y=0');
grid on;
plot(t,vort1(2,:),'b-');
legend('No stress','Dirchlet','Location','best');
hold off;

subplot(2,3,3)
hold on
plot(t,vort(3,:),'r-');
%plot(t,log(delvort(3,:)),'b');
xlabel('time [units]');
ylabel('vorticity');
title('Vorticity vs. Time for x=12, y=0');
grid on;
plot(t,vort1(3,:),'b-');
legend('No stress','Dirchlet','Location','best');
hold off;

subplot(2,3,4)
hold on
plot(t,vort(4,:),'r-');
%plot(t,log(delvort(4,:)),'b');
xlabel('time [units]');
ylabel('vorticity');
title('Vorticity vs. Time for x=18, y=0');
grid on;
plot(t,vort1(4,:),'b-');
legend('No stress','Dirchlet','Location','best');
hold off;

subplot(2,3,5)
hold on
plot(t,vort(5,:),'r-');
%plot(t,log(delvort(5,:)),'b');
xlabel('time [units]');
ylabel('vorticity');
title('Vorticity vs. Time for x=24, y=0');
grid on;
plot(t,vort1(5,:),'b-');
legend('No stress','Dirchlet','Location','best');
hold off;

subplot(2,3,6)
hold on
plot(t,vort(6,:),'r-');
%plot(t,log(delvort(6,:)),'b');
xlabel('time [units]');
ylabel('vorticity');
title('Vorticity vs. Time for x=30, y=0');
grid on;
plot(t,vort1(6,:),'b-');
legend('No stress','Dirchlet','Location','best');
hold off

% ln(deltavort)

figure(2)
subplot(2,3,1)
hold on
plot(t,omegat(1,:),'r-');
%plot(t,log(delvort(1,:)),'b');
xlabel('time [units]');
ylabel('ln(\Delta\omega)');
title('ln(\omega - \omega_o) vs. Time for x=0, y=0');
grid on;
plot(t,omegat1(1,:),'b-');
legend('No stress','Dirchlet','Location','best');
hold off;

subplot(2,3,2)
hold on
plot(t,omegat(2,:),'r-');
%plot(t,log(delvort(2,:)),'b');
xlabel('time [units]');
ylabel('ln(\Delta\omega)');
title('ln(\omega - \omega_o) vs. Time for x=6, y=0');
grid on;
plot(t,omegat1(2,:),'b-');
legend('No stress','Dirchlet','Location','best');
hold off;

subplot(2,3,3)
hold on
plot(t,omegat(3,:),'r-');
%plot(t,log(delvort(3,:)),'b');
xlabel('time [units]');
ylabel('ln(\Delta\omega)');
title('ln(\omega - \omega_o) vs. Time for x=12, y=0');
grid on;
plot(t,omegat1(3,:),'b-');
legend('No stress','Dirchlet','Location','best');
hold off;

subplot(2,3,4)
hold on
plot(t,omegat(4,:),'r-');
%plot(t,log(delvort(4,:)),'b');
xlabel('time [units]');
ylabel('ln(\Delta\omega)');
title('ln(\omega - \omega_o) vs. Time for x=18, y=0');
grid on;
plot(t,omegat1(4,:),'b-');
legend('No stress','Dirchlet','Location','best');
hold off;

subplot(2,3,5)
hold on
plot(t,omegat(5,:),'r-');
%plot(t,log(delvort(5,:)),'b');
xlabel('time [units]');
ylabel('ln(\Delta\omega)');
title('ln(\omega - \omega_o) vs. Time for x=24, y=0');
grid on;
plot(t,omegat1(5,:),'b-');
legend('No stress','Dirchlet','Location','best');
hold off;

subplot(2,3,6)
hold on
plot(t,omegat(6,:),'r-');
%plot(t,log(delvort(6,:)),'b');
xlabel('time [units]');
ylabel('ln(\Delta\omega)');
title('ln(\omega - \omega_o) vs. Time for x=30, y=0');
grid on;
plot(t,omegat1(6,:),'b-');
legend('No stress','Dirchlet','Location','best');
hold off

%% Determine growth rates
gr1 = gr(1,41:46);
gr2 = gr(2,34:45);
gr3 = gr(3,82:88);
gr4 = gr(4,40:53);
gr5 = gr(5,87:91);
gr6 = gr(6,40:46);

gr1 = mean(gr1);
gr2 = mean(gr2);
gr3 = mean(gr3);
gr4 = mean(gr4);
gr5 = mean(gr5);
gr6 = mean(gr6);

grate = (gr1 + gr2 + gr3 + gr4 + gr5 + gr6)/6;
grateerr = abs((grate-grt)/grt)*100;

grd1 = grd(1,18:43);
grd2 = grd(2,41:46);
grd3 = grd(3,19:38);
grd4 = grd(4,19:35);
grd5 = grd(5,27:40);
grd6 = grd(6,32:37);

grd1 = mean(grd1);
grd2 = mean(grd2);
grd3 = mean(grd3);
grd4 = mean(grd4);
grd5 = mean(grd5);
grd6 = mean(grd6);

grated = (grd1 + grd2 + grd3 + grd4 + grd5 + grd6)/6;
gratederr = abs((grated-grt)/grt)*100;
