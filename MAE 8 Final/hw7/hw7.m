clear all;
close all;
clc;
format long;
name = 'Levi Stein';
id = 'A16791467';
hw_num = '7';
%% Problem 1
load('matA.mat')
[r,c] = size(matA);
% (a) Sum all the elements in matA excluding the elements on the diagonal. Put the
% answer in p1a.
tmp_sum = 0;
for i = 1:r
    for j = 1:c
        if j==i 
            continue
        end
        tmp_sum = tmp_sum + matA(i,j);
    end
end
p1a = tmp_sum;
% (b) Sum all the elements that are above the diagonal. Put the answer in p1b.
sum_abv = 0;
for i = 1:r
    for j = 1:c
        if j<=i 
            continue
        end
        sum_abv = sum_abv + matA(i,j);
    end
end
p1b = sum_abv;
% (c & d) Starting with the element on the first row and the first column, progressively sum
% the elements along the row. After the first row, go onto the second row and continue on.
% Stop the computation when the sum first exceeds 55. Put the row and column indices of the
% last element added to the sum in p1c and p1d, respectively
cdsum = 0;
for i = 1:r
    for j = 1:c
        if cdsum >= 55
            break
        end
        cdsum = cdsum + matA(i,j);
        r_indc = i;
        c_indd = j;
    end
end
p1c = r_indc;
p1d = c_indd;
% (e & f) Starting with the element on the first row and the first column, search along the 
% columns for the first element that is a prime number and larger than 10. Put the row and
% column indices of the element in p1e and p1f, respectively
first_prime = 0;
for j = 1:c
    for i = 1:r
        if matA(i,j) <= 10
            continue
        elseif first_prime == 1
            break
        end
        first_prime = first_prime + isprime(abs(matA(i,j)));
        r_inde = i;
        c_indf = j;
    end
end
p1e = r_inde;
p1f = c_indf;
%% Problem 2
% (a)
p2a = evalc('help car');
% (b,c,d)
[p2b,p2c,p2d] = car(60,10);
% (e,f,g)
[p2e,p2f,p2g] = car(60,1);
% (h)
figure; hold on;
subplot(2,1,1)
plot(p2b,p2c,'d',p2e,p2f,'s','MarkerFaceColor','k')
subplot(2,1,2)
plot(p2b,p2d,'d',p2e,p2g,'s','MarkerFaceColor','k')
hold off;
p2h = 'See Figure 1';
%% Problem 3
%(a)
p3a = evalc('help rocket');
%(b)
[time, p3b, p3c] = rocket(9400,0.1);
%(c)
figure; hold on;
subplot(2,1,1)
plot(time, p3b, '-k','LineWidth',2)
subplot(2,1,2)
plot(time,p3c,'-k','LineWidth',2)
hold off
p3d = 'See figure 2';

%% Problem 4
load('stringB.mat');
% (a) How many sentences are there in stringB? Put the answer into p4a. Hint: A sentence ends with a period.
period_ind = strfind(stringB,'.');
p4a = numel(period_ind);
% (b) Replace all periods in stringB with a backslashes and put the answer into p4b.
p4b = strrep(stringB,'.','\');
% (c) Extract the first two sentences in stringB and put them in p4c.
p4c = stringB(1:period_ind(2));
% (d) Convert all upper-case letters in string p4c to lower-case and all lower-case letters into upper-case. 
% Put the answer in p4d.
ind_upper = find(upper(p4c) == p4c);
ind_lower = find(lower(p4c) == p4c);
p4d = p4c;
p4d(ind_upper) = lower(p4c(ind_upper));
p4d(ind_lower) = upper(p4c(ind_lower));
% for n=1:length(p4c)
%     flip =isstrprop(p4c(1,n),'lower');
%     if flip == 1
%         p4d(1,n) = upper(p4c(1,n));
%     else
%         p4d(1,n) = lower(p4c(1,n));
%     end
% end
% (e & f)
[p4e,p4f] = strtok(p4c,'.');
p4f(1) = [];
p4f(end) = [];
[blank,p4f] = strtok(p4f,'T');
% (g)
newstring = stringB;
counter = 0;
while ~isempty(newstring)
    [A, newstring] = strtok(newstring);
    if ~isempty(str2num(A))
        counter = counter + 1;
        p4g(counter) = str2num(A);
    end
    newstring = strtrim(newstring);
end
% for n = 1:length(newstring)
%     if isempty(str2num(strtok(newstring,' '),Evaluation='restricted'))
%         newstring(1:length(strtok(newstring,' '))) = [];
%     else
%         p4g(counter) = str2num(strtok(newstring,' '),Evaluation='restricted');
%         counter = counter + 1;
%         newstring(1:length(strtok(newstring,' '))+1) = [];
%     end
% end

