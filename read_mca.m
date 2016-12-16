%{
MIT License

Copyright (c) [2016] [Mallory Ann Jensen, jensenma@alum.mit.edu]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
%}

clear all; close all; 

%% As-grown MCA

file = 'Cr188_ROI1_part2.mca'; 

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

%Grab the real time
real_time = str2double(line6(14:end)); 

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
asgrown_data   = dlmread(newFile);

%% Gettered MCA

file = 'Cr_E072_188_part4.mca'; 

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

%Grab the real time
real_time = str2double(line6(14:end)); 

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
gettered_data   = dlmread(newFile);

%% Plot together for thesis figure
%scale the energy
x = 0:30/(2048-1):30; 

figure;
subplot(2,1,1); 
semilogy(x,asgrown_data);
axis([1 11 1 1e6]);
title('As-grown');
subplot(2,1,2); 
semilogy(x,gettered_data); 
ylabel('XRF counts per second'); 
axis([1 11 1 1e6]);
title('Gettered');

write_data = [x',asgrown_data,gettered_data];
xlswrite('mca_data.xlsx',write_data); 