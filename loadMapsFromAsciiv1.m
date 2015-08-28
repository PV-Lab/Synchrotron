%% loadMapsFromAsciiv1.m

startFileName = 'ASCII_';
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
