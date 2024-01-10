clear all; close all; clc; format long
name = 'Levi Stein';
id = 'A16791467';
hw_num = 'final';
form = 'A, B';

%% Problem 1: 
% You are to analyze the precipitation in San Diego. Load the file 
% rainfall.dat into MATLAB. The file includes the monthly-averaged 
% precipitation (in inches) from 1850 to 2021. The data is comma delimited 
% and the columns represent the year and the rainfall
% in Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, and Dec. 

load('rainfall.dat')


%% Problem 2: 



%% Problem 3: 
% You are to explore a contact list of 1,000 students given in the file 
% contact.mat. The file contains a 1000-row-by-4-column cell array contact.
% On each row are the last name, first name, class level and their phone
% number.

load('contact.mat')

% for n = 1:length(contact)
%     if strcmp(contact{n,3},'sophoremore')
%         contact{n,3} = 'sophomore';
%     end
% end



%% Problem 4: 
% You are to analyze the US air transportation data from 2003 to 2022
% given in the file air_passenger.mat. The file contains a 20-element vector 
% of structure air_passenger with the following four fields: 
% year: to include the year 
% month: a vector from 1 to 12 denoting the months from Jan to Dec
% domestic: a vector to include the monthly numbers of domestic messengers
% international: a vector to include the monthly numbers of domestic messengers

load('air_passenger.mat')


%% Problem 5: Physics simulation

