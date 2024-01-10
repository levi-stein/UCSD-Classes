function color = rgb_color(rgb)
%RGB_COLOR Takes a three element row vector (rgb) and mixes any given
%combination to return a color. The vector (rgb) must only contain values
%of 1 and 0 as they denote if the color is used (1) or unused (0).
%Call format: color = rgb_color(rgb)
if rgb(1) == 1
    if rgb(2) == 1
        if rgb(3) == 1
            color = 'white';
        else
            color = 'yellow';
        end % if on line 6
    else
        if rgb(3) == 1
            color = 'magenta';
        else
            color = 'red';
        end % if on line 12
    end % if on line 5
else
    if rgb(2) == 1
        if rgb(3) == 1
            color = 'cyan';
        else 
            color = 'green';
        end % if on line 20
    else 
        if rgb(3) == 1
            color = 'blue';
        else
            color = 'Invalid input';
        end % if on line 26
    end % if on line 19
end % if on line 4

end % function rgb_color