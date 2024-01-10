clear all;
close all;
clc;
format long;
name = 'Levi Stein';
id = 'A16791467';
hw_num = 3;
%% Problem 1:
% (a) How much money does each customer deposit? Put the answer in a five-element vector p1a.
a = [1 2 2 2 1]; mata = diag(a); A = [-1 -1 -1 -1]; matA = mata + diag(A,1)+ diag(A,-1); matA(1, 2) = 0; 
matA(5,4) = 0; b = [800 0 0 0 400]'; p1a = matA\b;
% (b) Repeat part (a), but the line now has 50 customers. Find the amount of each deposit and put the answer in a fifty-element
% vector p1b.
z = 2*eye(50); z(1,1) = 1; z(50,50) = 1;Z = linspace(-1,-1,49); matZ = z + diag(Z,1) + diag(Z,-1);
matZ(1, 2) = 0; matZ(50,49) = 0; c = [800 linspace(0,0,48) 400]'; p1b = matZ\c;
%% Problem 2:
% (a) Get the current date and time and store them in p2a (set p2a = clock). 
% The current date and time should be the date and time when your homework script is executed while being graded.
p2a = clock;
% (b) Using the format 'YYYY:MM:DD', write the current date to string p2b. 
% Here, YYYY, MM, and DD correspond to 4-digit year, 2-digit month, and 2-digit day, respectively.
p2b = sprintf('%4d:%02d:%2d',p2a(1),p2a(2),p2a(3));
% (c) Using the format 'HH:MM:SS.SSSS', write the current time to string p2c. 
% Here, HH, MM, and SS.SSSS correspond to 2-digit hour, 2-digit minute and 7-character second 
% (2 digits before the decimal point and 4 digits after the decimal points), respectively.
p2c = sprintf('%2d:%2d:%07.4f',p2a(4),p2a(5),p2a(6));
% (d) Remove the last 5 characters from the string in part (c) so that the format is now 'HH:MM:SS'. 
% Put the answer into string p2d.
p2d = sprintf('%2d:%2d:%02.0f',p2a(4),p2a(5),p2a(6));
% (e) Combine the strings in part (b) and part(d) together separated by a single space. Put the answer in string p2e.
p2e = sprintf('%2d:%2d:%07.4f %2d:%2d:%02.0f',p2a(4),p2a(5),p2a(6),p2a(4),p2a(5),p2a(6));
%% Problem 3:
G = [1 1/2 1/3 1/4; 1/5 1/6 1/7 1/8; 1/9 1/10 1/11 1/12]; A1 = [exp(G)];
% (a) Write the last column of matrix A into string p3a using %f with a field width of 6 characters 
% including 4 decimal places for each element. The string must show a column vector.
p3a = sprintf('%6.4f \n%6.4f \n%6.4f', A1(10),A1(11),A1(12));
% (b) Write the last row of matrix A into string p3b using %f with a field width of 5 characters
% including 3 decimal places for each element. The string must show a row vector.
p3b = sprintf('%5.3f %5.3f %5.3f %5.3f', A1(3),A1(6),A1(9),A1(12));
% (c) Write matrix A into string p3c using %f with a field width of 16 characters including 14 decimal places.
p3c = sprintf('%16.14f %16.14f %16.14f %16.14f \n%16.14f %16.14f %16.14f %16.14f \n%16.14f %16.14f %16.14f %16.14f',...
    A1(1),A1(4),A1(7),A1(10),A1(2),A1(5),A1(8),A1(11),A1(3),A1(6),A1(9),A1(12));
%% Problem 4:
% (a)
theta = 1:360; x = 16*(sind(theta)).^3; y = 13*cosd(theta)-5*cosd(2*theta)-2*cosd(3*theta)-cosd(4*theta);
figure; hold on;
plot(x,y,'-r','LineWidth',5); plot(x(end),y(end),'cd','MarkerSize',30,'MarkerFaceColor','c');
title('The Heart of Math'); xlabel('x'); ylabel('y'); legend('x vs. y','last data point','location','southeastoutside');savefig('figure 1'); hold off;
p4a = 'See figure 1';
% (b) Estimate the arc length of the curve. Approximate the arc length with straight lines between consecutive points.
% Put the answer in p4b.
dx = diff(x); dy = diff(y); ds = sqrt(dx.^2+dy.^2); p4b = sum(ds);
%% Problem 5:
% (a) 
theta1 = 0:0.05:1500; x1 = (1+0.25*cosd(50*theta1)).*cosd(theta1); y1 = (1+0.25*cosd(50*theta1)).*sind(theta1);
z1 = (pi*theta1/180)+2*sind(50*theta1);
dx1 = diff(x1); dy1 = diff(y1); dz1 = diff(z1); ds = sqrt(dx1.^2+dy1.^2+dz1.^2); p5a = sum(ds);
% (b) Create figure 2 and use function plot3 with the vectors x, y and z to plot the curve.
figure; hold on;
plot3(x1,y1,z1,'-m','LineWidth',0.5); hold on; 
plot3(x1(end),y1(end),z1(end),'r^','MarkerSize',10,'MarkerFaceColor','r');
plot3(x1(1),y1(1),z1(1),'ko','MarkerSize',10,'MarkerFaceColor','k');
xlabel('x');ylabel('y');zlabel('z');
title('Spring Coil Function');
legend('x vs. y vs. z', 'endpoint','startpoint', 'location', 'southeast'); 
view(3); savefig('figure 2'); hold off;
p5b = 'See figure 2';
%% Problem 6:
% (a) & % (b) 
load('temperature.dat'); temperature = importdata('temperature.dat');
max(max(temperature(:,2:13))); p6a = 9; p6b = 1984;
% (c) Between 1900 and 2000, how many times had the monthly temperature been warmer than 75◦? Put the answer in p6c.
r1900 = find(temperature(:,1) == 1900); r2000 = find(temperature(:,1) == 2000); p6c = sum(sum(temperature(r1900:r2000,2:13)>75));
% (d) During the summer (i.e., Jun, Jul and Aug) between 1900 and 2000, 
% how many times had the monthly temperature been warmer than 75◦? Put the answer in p6d.
p6d = sum(sum(temperature(r1900:r2000,7:9)>75));
% (e) Compute the annual cycle of the temperature by taking the average over the years for each of the months.
avgTmonths = mean(temperature(:,2:13)); figure; hold on; bar(1:12,avgTmonths);
title('Average Temperature in San Diego from 1852-2020');
xlabel('Months Jan-Dec'); ylabel('Avg Temp 1852-2020 (Farenheit)'); savefig('figure 3');hold off; p6e = 'See figure 3';
% (f) From figure 3, in what month of the cycle is the temperature warmest?
p6f = 'On average, the temperature peaks in the month of August';
% (g) Write the annual cycle of the temperature into a file named annual cycle.dat using ASCII format.
file_name = 'annual_cycle.dat'; months = [1:12]; out_data = [months' avgTmonths']; save(file_name,'out_data','-ascii');
p6g = evalc('type("annual_cycle.dat")');
% (h) Compute the annual mean temperature (i.e., the averaged temperature from Jan to Dec in each year)
years = [1852:2020]; temperature1 = temperature(:,2:13); avgTyear = mean(temperature1,2); 
figure; hold on; 
plot(years,avgTyear,'-k','LineWidth',2); 
morethan65 = avgTyear > 65; morethan65_x = years(morethan65);
morethan65_y = avgTyear(morethan65); plot(morethan65_x, morethan65_y, 'ro','MarkerFaceColor','r');
lessthan60 = avgTyear < 60; lessthan60_x = years(lessthan60); 
lessthan60_y = avgTyear(lessthan60); plot(lessthan60_x,lessthan60_y, 'bd', 'MarkerFaceColor', 'b');
title('Annual Mean tempertature in San Diego from 1852-2020'); xlabel('Year'); ylabel('Average Temperature (Farenheit)'); 
legend('Avg. Temp.', 'Avg. Temp. > 65', 'Avg. Temp. < 60', 'location', 'southeast'); savefig('figure 4'); hold off;
p6h = 'See figure 4';
% (i) In figure 4, does the temperature in San Diego get warmer or cooler over the years?
p6i = 'On average, the temperature in San Diego gets warmer over the years';