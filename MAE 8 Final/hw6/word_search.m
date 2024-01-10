function  [indices_first_letter, indices_last_letter] = word_search(word)
% WORD_SEARCH takes the character input word and returns the row- and column- 
% indices of the first and last characters in the string word as the string  
% appears inside the puzzle. The two-element vector output
% indices_first_letter stores the row- and column-indices of the first character. 
% Similarly, the two-element vector output indices_last_letter stores the row- 
% and column-indices of the last character. The function also displays the puzzle 
% with the word being highlighted.
%
% The word is read from left to right and top to bottom in the puzzle, not in 
% reverse order. Same rule is applied for the word that appears on the diagonal.
%
% Call format: [indices_first_letter, indices_last_letter] = word_search(word)


%% Load puzzle into MATLAB
load('puzzle.mat')

% initialize outputs with nan
indices_first_letter = [nan nan];
indices_last_letter = [nan nan];


%% Find the row and column indices of the first and last letters of word in the puzzle
% This section is to be completed by the students.

% Check row-wise
% For every row, check whether word appears on that row
% If word is found, record indices_first_letter and indices_last_letter
for n = 1:size(puzzle,1)
    for  m = 1:size(puzzle,2)-length(word)
        if word == puzzle(n,m:m+length(word)-1)
            indices_first_letter = [n,m];
            indices_last_letter = [n,m+length(word)-1];
        end
    end
end

% Check column-wise
% For every column, check whether word appears on that column
% If word is found, record indices_first_letter and indices_last_letter

for col = 1:20
    thiscol = puzzle(:,col);
    for w = 1:length(word)
        row_loc = strfind(thiscol',word);
        if ~isempty(row_loc)
            indices_first_letter = [row_loc, col];
            indices_last_letter = [row_loc+length(word)-1, col];
        end
    end
end

% Check diagonal
% For each row and column indices (n,m) in puzzle, extract a square 
% sub-matrix matA with a dimension of length(word). Use function diag to extract 
% the diagonal of matA. Check whether diag(matA) matches with word.
% if WORD is found, record indices_first_letter and indices_last_letter
for n = 1:size(puzzle,1)-length(word)
    for m = 1:size(puzzle,2)-length(word)
        matA = puzzle(n:n+length(word)-1,m:m+length(word)-1);
        if diag(matA)' == word
            indices_first_letter = [n,m];
            indices_last_letter = [n+length(word)-1,m+length(word)-1];
        end
    end
end


%% This section displays the puzzle and highlight the word.
% This section requires completion of the section above.
% When you are working on the section above, it is recommended that you
% comment out this section.

figure('Units','inches','Position',[1,1,10,8]); hold on;
axis([0.5 20.5 0.5 20.5]);
box on; grid on;
set(gca,'Ydir','reverse','XAxisLocation','top','FontSize',14);
set(gca,'XTick',1:20,'YTick',1:20);
set(gca,'XTickLabel',1:20,'YTickLabel',1:20);

if indices_first_letter(1) == indices_last_letter(1) % row
    plot([indices_first_letter(2)-0.5 indices_last_letter(2)+0.5],...
        [indices_first_letter(1) indices_last_letter(1)],...
        'Color','y','LineWidth',15);
elseif indices_first_letter(2) == indices_last_letter(2) % column
    plot([indices_first_letter(2) indices_last_letter(2)],...
        [indices_first_letter(1)-0.5 indices_last_letter(1)+0.5],...
        'Color','y','LineWidth',15);
else  % diagonal
    plot([indices_first_letter(2)-0.25 indices_last_letter(2)+0.25],...
        [indices_first_letter(1)-0.25 indices_last_letter(1)+0.25],...
        'Color','y','LineWidth',15);
end

for n = 1:size(puzzle,1)
    for m = 1:size(puzzle,2)
        text(n-0.2,m,puzzle(m,n),'FontSize',15);
    end
end
ylabel('row indices');
xlabel('column indices');
text(6,22,sprintf('Searching for ''%s''',word),'color','red','FontSize',20);

end % function word_search