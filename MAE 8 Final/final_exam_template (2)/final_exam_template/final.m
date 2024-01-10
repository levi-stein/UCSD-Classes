clear all; close all; clc; format long
name = 'Levi Stein';
id = 'A16791467';
hw_num = 'final';
form = 'B';

%% Problem 1: 
% You are to analyze the precipitation in San Diego. Load the file 
% rainfall.dat into MATLAB. The file includes the monthly-averaged 
% precipitation (in inches) from 1850 to 2021. The data is comma delimited 
% and the columns represent the year and the rainfall
% in Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, and Dec. 

load('rainfall.dat')
p1a = max(max(rainfall(:,2:13)));
[r, c] = find(rainfall == p1a);
p1b = rainfall(r,1);

r1980 = find(rainfall(:,1) == 1980);
p1c = max(rainfall(r1980,2:13));
p1d = find(rainfall(r1980,2:13) == p1c);

r1950 = find(rainfall(:,1) == 1950);
r1999 = find(rainfall(:,1) == 1999);

p1e = sum(sum(rainfall(r1950:r1999,2:13) > 5));
counter = 1;
for n = 1:length(rainfall)
    if rainfall(n,2) > 5.14
        p1f(counter) = rainfall(n,1);
        counter = counter + 1;
    end
end

%% Problem 2: 
x = -1:0.01:1;
f = 0.1 + sqrt(1 - x.^2);
g = 2*exp(-4*(x).^2);

dx = diff(x);
df = diff(f);
dg = diff(g);
deriv_g = dg./dx;
p2a = deriv_g(x == 0.75);

p2b = sum(sqrt((dx).^2 + (df).^2));

figure; hold on;
plot(x,f,'-r');
plot(x,g,'-k');
xlabel('x'); ylabel('f(x) & g(x)'); title('f(x) vs. g(x)');
legend('f(x) = 0.1 + sqrt(1 - x.^2)','g(x) = 2*exp(-4*(x).^2)');
p2c = 'See figure 1';
approx = abs(f-g);
counter = 0;
for n = 2:length(approx)-1
    if approx(n) <= approx(n-1) && approx(n) <= approx(n+1)
        counter = counter + 1;
        xloc(counter) = x(n);
        floc(counter) = f(n);
        gloc(counter) = g(n);
    end
end
indg = find(g == gloc(1));
indf = find(f == floc(1));
p2d = dx(1)*(0.5*(g(indg(1))+g(indg(end)))+sum(g(indg(1)+1:indg(end)-1))) -...
    dx(1)*(0.5*(f(indf(1))+f(indf(end)))+sum(f(indf(1)+1:indf(end)-1)));
hold off;
%% Problem 3: 
% You are to explore a contact list of 1,000 students given in the file 
% contact.mat. The file contains a 1000-row-by-4-column cell array contact.
% On each row are the last name, first name, class level and their phone
% number.
load('contact.mat')
for n = 1:length(contact)
    if ~isempty(strfind(contact{n,1}, 'Hurst'))
        Hurst = [n,1];
        if ~isempty(strfind(contact{n,2}, 'Westley'))
            Westley = [n,2];
            break
        end
    end
end
p3a = contact{Westley(1),4};

for n = 1:length(contact)
    phone_num = contact{n,4};
    if phone_num == 5973682687
        p3b = [contact{n,2} contact{n,1}];
    end
end

counter_fresh = 0;
for n = 1:length(contact)
    if ~isempty(strfind(contact{n,3}, 'freshman'))
        counter_fresh = counter_fresh + 1;
    end
end
counter_junior = 0;
for n = 1:length(contact)
    if ~isempty(strfind(contact{n,3}, 'junior'))
        counter_junior = counter_junior + 1;
    end
end

p3c = counter_fresh + counter_junior;

p3d = 0;
for n = 1:length(contact)
    area_code = num2str(contact{n,4});
    if all(area_code(1:3) == '719')
        p3d = p3d + 1;
    end
end

%% Problem 4: 
% You are to analyze the US air transportation data from 2003 to 2022
% given in the file air_passenger.mat. The file contains a 20-element vector 
% of structure air_passenger with the following four fields: 
% year: to include the year 
% month: a vector from 1 to 12 denoting the months from Jan to Dec
% domestic: a vector to include the monthly numbers of domestic messengers
% international: a vector to include the monthly numbers of international messengers

load('air_passenger.mat')
ind_2020 = 2020 - air_passenger(1).year + 1;
p4a = max(air_passenger(ind_2020).domestic);
p4b = min(air_passenger(ind_2020).domestic);

ind_2019 = 2019 - air_passenger(1).year + 1;
p4c = air_passenger(ind_2019).domestic(7);
p4d = air_passenger(ind_2019).international(7);


for n = 1:length(air_passenger)
    apr_dom(n) = air_passenger(n).domestic(4);
end
years = [air_passenger.year];
figure; hold on;
bar(years,apr_dom);
xlabel('Years 2003-2022'); ylabel('# of passengers');
max_apr = max(apr_dom);
min_apr = min(apr_dom);
year_max = find(apr_dom == max_apr);
year_min = find(apr_dom == min_apr);
plot(air_passenger(year_max).year,max_apr,'ro','MarkerFaceColor','r','MarkerSize',10);
plot(air_passenger(year_min).year,min_apr,'bo','MarkerFaceColor','b','MarkerSize',10);
title('Domestic US Passengers from 2003-2022 in Apr');
legend('number of passengers','largest passenger count','lowest passenger count','Location','SouthWest');
hold off;
for n = 1:length(air_passenger)
    jul_dom(n) = air_passenger(n).domestic(7);
end
for n = 1:length(air_passenger)
    dec_dom(n) = air_passenger(n).domestic(12);
end
p4e = 'See figure 2';
p4f = all(dec_dom < jul_dom);
%% Problem 5: Physics simulation
a = 5*10^-8;
[T,p5a,p5b,p5c] = epidemic(a,0.35);
figure; hold on;
plot(T,p5a,'-k','LineWidth',2);
plot(T,p5b,'-r','LineWidth',2);
plot(T,p5c,'-b','LineWidth',2);
xlabel('Time (day)');ylabel('# of people'); title('Infection Spread & Recovery vs Time');
legend('Susceptible people','Infected people','Recovered people');
p5d = 'See figure 3';
hold off;

figure; hold on;
r = 0.25:0.05:0.45;
cs = 'rbkgm';
for n = 1:5
    [T1{n},S{n},I{n},R{n}] = epidemic(a,r(n));
    plot3(S{n},I{n},R{n},cs(n),'LineWidth',1);
end
legend('r = 0.25','r = 0.3','r = 0.35','r = 0.4','r = 0.45')
xlabel('Susceptible People');ylabel('Infected people');zlabel('Recovered People');
title('S vs. I vs. R'); view(3); box on; grid on;
p5e = 'See figure 4';