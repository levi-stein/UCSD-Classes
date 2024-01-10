clear all; close all; clc; format long
name = 'fill in your name';
id = 'fill in your id';
hw_num = 'final';
form = 'fill in your form letter (e.g., A, B, etc.)';

%% Problem 1: 
load('temperature.dat')
[r, c] = find(temperature == min(min(temperature(:,2:13))));
p1a = min(min(temperature(:,2:13)));
p1b = r+1851;

r1900 = find(temperature == 1900);
p1c = min(temperature(r1900,:));
p1d = find(temperature(r1900,:) == min(temperature(r1900,:)))-1;

r1999 = find(temperature == 1999);
p1e = sum(sum(temperature(r1900:r1999,2:13) < 65));

for n = 1:length(temperature)
    avg_tmp(n) = mean(temperature(n,[13,2,3]));
end
p1f = avg_tmp;

%% Problem 2: 
p2a = 0;
for k = 1:10
    for l = 1:k
        for m = 1:l
            p2a = p2a + 1/(3^k + 3^l + 3^m);
        end
    end
end

x = -12:0.1:12;
y = -10:0.1:10;

f = zeros(length(x),length(y));
for n = 1:length(x)
    for m = 1:length(y)
        f(n,m) = exp(-1*(cos(x(n)/2)+sin(y(m)/3))^2);
    end
end
figure; hold on;
surf(x,y,f');shading interp;
view(3);

counter = 0;
for n = 2:length(x)-1
    for m = 2:length(y)-1
        nb(1) = f(n+1,m-1);
        nb(2) = f(n+1,m);
        nb(3) = f(n+1,m+1);
        nb(4) = f(n,m+1);
        nb(5) = f(n-1,m+1);
        nb(6) = f(n-1,m);
        nb(7) = f(n-1,m-1);
        nb(8) = f(n,m-1);
        if f(n,m) >= max(nb)
            counter = counter + 1;
            x_loc_max(counter) = x(n);
            y_loc_max(counter) = y(m);
            f_loc_max(counter) = f(n,m);
        end
    end
end
plot3(x_loc_max,y_loc_max,f_loc_max,'ro','MarkerFaceColor','r');
xlabel('x');ylabel('y');zlabel('f'); title('f vs x and y');
legend('f(x,y)','local maxima');
hold off;
p2b = 'see figure 1';
%% Problem 3:
load('survey.mat')
p3a = any(strfind(survey{1},'Yes')) == any(strfind(survey{end},'Yes')); 
p3b = any(strfind(survey{50},'Yes')) == any(strfind(survey{100},'Yes'));
counter = 0;
for n = 1:length(survey)
    if any(strfind(survey{n},'Yes'))
        counter = counter + 1;
    end
end
p3c = counter;
counter = 0;
for n = 1:length(survey)
    if any(strfind(survey{n},'Yes'))
        if any(strfind(survey{n},'Difficult'))
            counter = counter + 1;
        end
    end
end
p3d = counter;

%% Problem 4: 
load('SDweather.mat')
for n = 1:length(SDweather)
    if any(find(SDweather(n).year == 1950))
        ind = n;
        break
    end
end
p4a = max(SDweather(ind).temperature);
p4b = find(SDweather(ind).temperature == max(SDweather(ind).temperature));

for n = 1:length(SDweather)
    min_rain(n) = min(SDweather(n).rainfall);
end

p4c = 0;
p4d = find(min_rain == 0) + SDweather(1).year-1;

avg_tmp = [SDweather.annual_temperature_avg];
years = [SDweather.year];
figure; hold on;
plot(years,avg_tmp,'-k');

max_avg_tmp = max(avg_tmp);
max_avg_tmp_year_ind = find(avg_tmp == max(avg_tmp));
plot(SDweather(max_avg_tmp_year_ind).year,max_avg_tmp,'ro','MarkerFaceColor','r','MarkerSize',10)
min_avg_tmp = min(avg_tmp);
min_avg_tmp_year_ind = find(avg_tmp == min(avg_tmp));
plot(SDweather(min_avg_tmp_year_ind).year,min_avg_tmp,'bo','MarkerFaceColor','b','MarkerSize',10)
xlabel('years');ylabel('avg tmp (F)');title('Avg Tmp in SD from 1852-2020');
legend('Avg annual tmp','max annual tmp','min annual tmp');
hold off;
% for n = 1:length(SDweather)
%     max_tmp(n) = max(SDweather(n).temperature);
% end
% max_tmp_year_ind = find(max_tmp == max(max_tmp));
% plot(SDweather(max_tmp_year_ind).year,max(SDweather(max_tmp_year_ind).temperature),'ro','MarkerFaceColor','r');
%% Problem 5: 
mass = 0.1;
[T,X,Y,Z,U,V,W] = tennis_trajectory(0,0,30,10,20,15);
p5a = [X(end) Y(end) Z(end)];
p5b = [U(end) V(end) W(end)];

p5c = sum(sqrt(diff(X).^2 + diff(Y).^2 + diff(Z).^2));
max_h_z = max(Z);
max_h_ind = find(Z == max(Z));
for n = 1:length(T)
    PE(n) = mass*9.81*Z(n);
    KE(n) = 0.5*mass*(U(n)^2 + V(n)^2 + W(n)^2);
end
dE = abs(PE-KE);
counter = 0;
for n = 2:length(dE)-1
    if dE(n) <= dE(n-1) && dE(n) <= dE(n+1)
        counter = counter + 1;
        xloc_PEKE(counter) = X(n);
        yloc_PEKE(counter) = Y(n);
        zloc_PEKE(counter) = Z(n);
    end
end

figure; hold on;
plot3(X,Y,Z,'-k');
plot3(X(1),Y(1),Z(1),'ok','MarkerFaceColor','k');
plot3(X(max_h_ind),Y(max_h_ind),max_h_z,'rs','MarkerFaceColor','r');
plot3(xloc_PEKE,yloc_PEKE,zloc_PEKE,'bv','MarkerFaceColor','b');
plot3(X(end),Y(end),Z(end),'dm','MarkerFaceColor','m');
xlabel('x (m)'); ylabel('y (m)'); zlabel('z (m)');
title('Tennis ball trajectory');
legend('Trajectory','Initial position','max height','PE = KE',...
    'landing position','Location','best');
p5d = 'See figure 3';
view(3); box on; grid on; hold off;
 
