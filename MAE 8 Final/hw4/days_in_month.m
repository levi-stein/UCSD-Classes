function days = days_in_month(month,leap)
%DAYS_IN_MONTH Takes two inputs, a string with the first three letters of
%any given month (month) and a 1 or 0 denoting wether a leap year occurs.
%Output will return the amount of days in that month based on if it is a
%leap year or not. Note: all letters in month string must be lowercase.
%Call format: days = days_in_month(month,leap)

switch leap
    case 0
        switch month
            case {'apr','jun','sep','nov'}
                days = 30;
            case {'jan','mar','may','jul','aug','oct','dec'}
                days = 31;
            case {'feb'}
                days = 28;
            otherwise
                days = 'invalid input';
        end % switch on line 7
    case 1
        switch month
            case {'apr','jun','sep','nov'}
                days = 30;
            case {'jan','mar','may','jul','aug','oct','dec'}
                days = 31;
            case {'feb'}
                days = 29;
            otherwise
                days = 'invalid input';
        end % switch on line 5

end % function days_in_month