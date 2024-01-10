function amount = lottery(ticket)
%LOTTERY Takes an input vector of six numbers and returns an output value
%corrsponding to the amount of money won. Each number of the input value
%matching a number of the winning number will return amounts of 10^n with n
%being the amount of correcly matched numbers.
% Call format: amount = lottery(ticket)
load('winning_number.dat'); % loads the winning numbers into a 6 element vector.
match = intersect(ticket,winning_number); % creates a new vector match that stores any matching numbers of ticket and winning_number.
if numel(match) == 1 % assigns a value to amount of elements in the matching vector.
    amount = 10;
elseif numel(match) == 2
    amount = 100;
elseif numel(match) == 3
    amount = 1000;
elseif numel(match) == 4
    amount = 10000;
elseif numel(match) == 5
    amount = 100000;
elseif numel(match) == 6
    amount = 1000000;
else
    amount = 0;
end % if on line 9

end % ends the function