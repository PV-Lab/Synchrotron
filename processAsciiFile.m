function [map] = processAsciiFile(file,cutoff_flag,cutoff_min,cutoff_max)
%process 2IDD ascii output

%Error handling

if nargin < 1
    error('Function requires one input argument');
elseif ~ischar(file)  % AEM old version: elseif ~isstr(file)
    error('Input must be a string representing a filename');
end

% Open the file.  If this returns a -1, we did not open the file
% successfully.
fid = fopen(file);
if fid == -1
    error('File not found or permission denied');
end

% Initialize loop variables
% We store the number of lines in the header, and the maximum
% length of any one line in the header.  These are used later
% in assigning the 'header' output variable.
no_lines = 0;
max_line = 0;


% We also store the number of columns in the data we read.  This
% way we can compute the size of the output based on the number
% of columns and the total number of data points.
ncols = 0;


% Finally, we initialize the data to [].
data = [];


% Start processing.
line = fgetl(fid);
if ~ischar(line) % if ~isstr(line)
    disp('Warning: file contains no header and no data')
end%;
[data, ncols, errmsg, nxtindex] = sscanf(line, '%f');


%This part of the program takes most of the
% processing time, because fgetl is relatively slow (compared to
% fscanf, which we will use later).
while isempty(data)||(nxtindex==1)
    no_lines = no_lines+1;
    max_line = max([max_line, length(line)]);
    % Create unique variable to hold this line of text information.
    % Store the last-read line in this variable.
    eval(['line', num2str(no_lines), '=line;']);
    line = fgets(fid);
    if ~ischar(line) %if ~isstr(line)
        disp('Warning: file contains no data')
        break
    end;
    [data, ncols, errmsg, nxtindex] = sscanf(line, '%f');
end % while

% Create header output from line information. The number of lines
% and the maximum line length are stored explicitly, and each
% line is stored in a unique variable using the 'eval' statement
% within the loop. Note that, if we knew a priori that the
% headers were 10 lines or less, we could use the STR2MAT
% function and save some work. First, initialize the header to an
% array of spaces.
header = setstr(' '*ones(no_lines, max_line));
for i = 1:no_lines
    varname = ['line' num2str(i)];
    % Note that we only assign this line variable to a subset of
    % this row of the header array.  We thus ensure that the matrix
    % sizes in the assignment are equal.
    eval(['header(i, 1:length(' varname ')) = ' varname ';']);
end


%Now remove the header from the file and dump into new file, then use
%dlmread to get data

file = file(1:(end-4)); %removes extension
newFile = [file 'noHeader.txt'];
fidd = fopen(newFile,'w') ; % the new file

fwrite(fidd,line);  %add the first line of data

while ~feof(fid) ; % reads the original till last line
    tline = fgets(fid) ; %
    if isletter(tline(1))==1
        header = [header; tline];
    else
        fwrite(fidd,tline) ;
    end
end
fclose all ;

%Read in data
data   = dlmread(newFile);

map.data   = data;

% if cutoff_flag ==1
%     cutoffs = cutoff_min:1:cutoff_max;
%     for i = 1:length(cutoffs)   
%         column = map.data(:,3);
%         index = find((column)==cutoffs(i));
%         map.data(index,:) = [];
%     end
% end
    

map.header = header;
map.cts    = map.data(:,1);
map.xPixel = map.data(:,2);
map.yPixel = map.data(:,3);
map.xValue = map.data(:,4);
map.yValue = map.data(:,5);

xMax = map.xPixel(end)+1;  %zero indexed array
yMax = map.yPixel(end)+1;

counts = zeros(yMax,xMax);

%In the ascii file y increments along the entire line first, then x, so here loop x
%first then y
n = 0;
for i = 1:xMax
    for j = 1:yMax
        n = n+1;
        counts(j,i) = map.cts(n);
    end
end

map.counts = counts;