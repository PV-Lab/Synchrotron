%{
MIT License

Copyright (c) [2016] [Mallory Ann Jensen, jensenma@alum.mit.edu]
Note: File contents from David P. Fenning. 

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

%% loadMapsFromAsciiv1.m
%2017c1
% startFileName = 'C:\Users\Mallory Jensen\Documents\Synchrotron\HPMC vs. mc-Si\Synchrotron data\2017c1 Barry quantified\output\ASCII_';
%2017c2
startFileName = 'C:\Users\Mallory Jensen\Documents\Synchrotron\HPMC vs. mc-Si\Synchrotron data\2017c3 MIT quantified\output\ASCII_';
endFileName   = '.h5.txt'; % for quantified

%endFileName   = '.img.dat.txt'; % for quantified
%endFileName = '.mda.txt'; % for unquantified

[m, n] = size(Samples);

for j = 1:m              % AEM usually there's just one row
    for i = 1:n          % AEM for the number of samples we've selected
        sampleName = Samples{j,i};           % AEM get the sample name
        if ~strcmp(hiResScans{j,i},'0000')   % AEM as long as the hiRes scan is not 0000
            for k = 1:length(channelsToLoad) % AEM for the number of channels you want to load
                % process the ASCII file into map structures
                % build ASCII file name for data extraction
                fileName = [startFileName channelsToLoad{k} '_2idd_' hiResScans{j,i} endFileName];
                fprintf('fileName: %s\n',fileName)
                
                fromMaps.(sampleName).(channelsToLoad{k}) = processAsciiFile(fileName);
                fromMaps.(sampleName).title = sampleName;
                fromMaps.(sampleName).(channelsToLoad{k}).title = sampleName;
            end
            fprintf('Data imported for %s \n', sampleName);
        else
            fprintf('No data was taken for %s \n', sampleName);
        end
    end
end

%% END
