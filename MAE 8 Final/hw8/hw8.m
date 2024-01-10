clear all;
close all;
clc;
format long;
name = 'Levi Stein';
id = 'A16791467';
hw_num = '8';
%% Problem 1
fid = fopen('survey_result.txt','r');
counter = 0;
while ~feof(fid)
    aline = fgetl(fid);
    counter = counter + 1;
    [Q1, rest] = strtok(aline);
    [Q2, rest] = strtok(rest);
    [Q3, rest] = strtok(rest);
    [Q4, rest] = strtok(rest);
    rest = fliplr(rest);
    [Q6, Q5] = strtok(rest);
    Q5 = strtrim(fliplr(Q5));
    Q6 = strtrim(fliplr(Q6));
    survey(counter).Q1 = Q1;
    survey(counter).Q2 = Q2;
    survey(counter).Q3 = Q3;
    survey(counter).Q4 = Q4;
    survey(counter).Q5 = Q5;
    survey(counter).Q6 = Q6;
end
fclose(fid);
% (a)
Q1_all = [survey.Q1];
target_string = {'Freshman','Sophomore','Junior','Senior','Null'};
for n = 1:length(target_string)
    class_level(n) = numel(strfind(Q1_all,target_string{n}));
end
figure;
bar(class_level);
xlabel('class level'); ylabel('number of students');
title('class level distribution MAE 8');
set(gca,'XTickLabel',target_string);
p1a = 'See Figure 1';
% (b)
Q5_all = [survey.Q5];
target_string1 = {'>= 10','7 - 9'};
for n = 1:length(target_string1)
    students(n) = numel(strfind(Q5_all,target_string1{n}));
end
p1b = sum(students);
% (c)
p1c = 0;
for n = 1:length(survey)
    if strcmp(survey(n).Q1,'Sophomore') && strcmp(survey(n).Q2,'Yes')
            p1c = p1c + 1;
    end
end
% (d)
p1d = 0;
for n = 1:length(survey)
    if strcmp(survey(n).Q1,'Sophomore') && strcmp(survey(n).Q2,'Yes') && strcmp(survey(n).Q6,'Difficult')
            p1d = p1d + 1;
    end
end
%% Problem 2
% (a)
element = struct('name','helium','symbol','He','atomicNumber',2,'atomicWeight',4,'electrons',[2 0 0 0 0 0 1]);
p2a = element;
% (b)
p2b = element;
p2b.name = 'Helium';
% (c)
newweight = 4.002602;
p2c = p2b;
p2c.atomicWeight = newweight;
% (d)
p2d = p2c;
p2d.electrons(end) = 0;
%% Problem 3
% (a - c)
K{1} = @(C) C + 273.15;
K{2} = @(F) (5/9)*(F + 459.67);
p3a = K;
p3b = K{1}(20);
p3c = K{2}(90);
% (d - f)
R = 0.08206;
P = @(n,T,V) (n*R*T)/V;
p3d = P;
p3e = P(0.12,K{1}(27),4);
p3f = P(0.12,K{2}(90),4);
