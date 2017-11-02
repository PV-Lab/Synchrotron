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

%XRF processing from 2IDD

%Process:
%Export fitted 2-ID-D img.dat data using MAPS with fitted and !!US-IC!! as parameters
%generate separate ASCIIs, being sure to include the elastic channel too
%preferably Si, Ca, Ti, V, Cr, Mn, Fe, Co, Ni, Cu, Zn, and s_e

%create a sampleInfo file like sampleInfoLTA include the Samples array, the hiResScans array,
%and the possible channels array for the data, and the directory where the
%data is

%%%%

%% Choose which samples to process and which channels to load
    sampleInfoHPMCvConv;

    channelsToLoad = {'Cu','s_e'}; %Always need s_e for GBanalysis.  These have to have been outputted as ASCIIs
    
    %%
if ~exist('fromMaps','var')
    %clear all;
    
    loadMapsFromAsciiv1;
    
    %loadQuantMapsFromAscii10c1; %recalibrated
    %loadLTAMapsFromAsciiv2badMaps; %I2E LTA ROI sum USIC weird filenames,
    %this was used for Fenning's APL 2011
    %loadLTAMapsFromAsciiv2; %I2E LTA fitted USIC

else
    clear fitted quant; %clears the previous fitted data in order to redo analysis
end

%%
[q tt] = size(Samples);

%Could run this outer loop for multiple cutoff values to assess what the
%best cutoff value may be. Adjust the value/structure of w in order to do
%this. 
for w = 3.5  %3 for HiT, 3.5 for I2Eb, 3bkgdSubt for I2ELTA, 3.5 for Cr (for comparison purposes only - otherwise 4.05 seems to be a good value)
for u = 1:q
    for v = 1:tt
        
        sampleName = Samples{u,v};  %Samples should be in workspace from loading
        
         if ~strcmp(hiResScans{u,v},'0000') %make sure that the high res scan actually exists
            
 
    %% fit the background data
    %%%%%%%%%%%%%%%%%%%%%%%  FITTING ROUTINE PARAMETERS 
    nSigma = w;
    cutoff = 99; %percentile to include for fitting normal distribution mle
    showSaveFitPlots = 'n';
    savePlots = 'off';
    
    %%%%%%%%%%%%%%%%%%%%%%%
    
            %Could use the next few lines to set a specific cutoff for one
            %sample if needed
%             if strcmp(hiResScans{u,v},'0122')
%                 cutoff = 55;
%             end
            
            %fit background of each map and plot using backgroundRemoval.m
            
            channelsToKeep = {'s_e'};
            channelsToFitBkgd = channelsToLoad; 
            
            for k = 1:length(channelsToFitBkgd)
                fitted.(sampleName).(channelsToFitBkgd{k}) = fitBackground(fromMaps.(sampleName).(channelsToFitBkgd{k}), nSigma, cutoff);  
                fprintf('%s data fitted for %s \n', channelsToFitBkgd{k}, [sampleName 'fitted']);

                if strcmp(showSaveFitPlots,'y')

                    if strcmp(savePlots,'on')
                        newDir = sprintf('Quantified %s Maps Fit %d sigma %d prctile cutoff v2', channelsToFitBkgd{k}, nSigma, cutoff);
                        oldDir   = pwd;
                        if ~exist(newDir,'dir')
                            mkdir(oldDir, newDir);
                        end
                        cd(newDir);
                    end

                    XYdisplay2IDD13c3(fitted.(sampleName).(channelsToFitBkgd{k}),'saveplots',savePlots);
                    if strcmp(savePlots,'on')
                        cd(oldDir); 
                    end
                end
            end
            
            %add the elastic channel so it can be used to analyze particle
            %depth
            for l = length(channelsToKeep)
                fitted.(sampleName).(channelsToKeep{l}) = fromMaps.(sampleName).(channelsToKeep{l});
             
            end

    %% quantify the data now that background is out of the way
            
    %%%%%%%%%%%%%%%% QUANT PARAMETERS 
    bkgdAnalysis = 'removed'; 
        %removed - sets the points determined to be below the
        %noiseMean+nSigma to zero
        %nSigmaSubtracted - subtracts the noiseMean+nSigma from all data
        %points
        %subtracted - subtracts the noiseMean from the data
        
    quantOptions = struct('channel','Cu','scaling','off','background',bkgdAnalysis,'fitorder','3','manualgbline','n','plots','on','plotScale','linear') ;
    %%%%%%%%%%%%%%%%   
            
            quant.(sampleName) = pcpDistAnalysisv1(fitted.(sampleName), quantOptions);
            fprintf('Data quantified for %s \n', [sampleName 'quant']);
            sigmaString = num2str(nSigma*10);
            if strcmp(sigmaString(end),'0')
                sigmaString = sigmaString(1:end-1);
            else
                sigmaString = [sigmaString(1) 'p' sigmaString(end)];
%                 sigmaString(strfind(num2str(nSigma),'.')) = 'p';
            end
            print(gcf,'-dpng', sprintf('%s%s%dSigs',quant.(sampleName).title,bkgdAnalysis,sigmaString));
        else
            fprintf('No data was taken for %s \n', sampleName);
         end
       
         
        
%         close all; %close the fitting plots (if they were shown)
    end
end

beep2(261.6); beep2(440);

% save([sprintf('I2Ebquant%ssigBkgdwMDL%s',sigmaString,bkgdAnalysis) date]);
 
%% Prepare data for the boxplot

sampleNames = sort(fieldnames(quant));
nSamples = length(sampleNames);

Pcps = cell(1,nSamples);
noiseFloorAtoms = zeros(1,nSamples);
noiseFloorR = zeros(1, nSamples);

for i = 1:nSamples
    
    Pcps{i} = quant.(sampleNames{i}).particleN_Cu_atomsAdj;
    noiseFloorAtoms(i) = quant.(sampleNames{i}).noiseLimitAtoms;
    noiseFloorR(i) = quant.(sampleNames{i}).noiseLimitR;
    noiseMeanAtoms(i) = quant.(sampleNames{i}).noiseMeanAtoms;
    meanAtoms(i) = mean(Pcps{i});
    medianAtoms(i) = median(Pcps{i});
%     bigParts{i} = quant.(sampleNames{i}).bigParticle;
end


pcpdata = cell2mat(Pcps)';
% bigParticle = cell2mat(bigParts)';
nPcps = cellfun('length',Pcps);

%labels for the boxplot
labels = [];
labelNames = char(sampleNames(1:end));

for i = 1:size(labelNames)
 labels = [labels; repmat(labelNames(i,:), nPcps(i),1)];
end

%individual pcp data points
X = -1*ones(1,sum(nPcps));
Y = -1*ones(1,sum(nPcps));
n = 0;
increment = 5;
for i = 1:nSamples
    for j = 1:nPcps(i)
        n = n+1;
        X(n) = i*increment-0.4*increment;
        Y(n) = Pcps{i}(j);
        pcpnumber(n) = j;
%         h(n)= text(X(n)+J(n),Y(n),num2str(pcpnumber(n))); %,'BackgroundColor','w');
        
    end
end
%Add jitter
jitter = 0.15*increment;
J=(rand(size(X))-0.5)*jitter;

boxPositions = 0.5:increment:(0.5+increment*(nSamples-1));

figure;
boxplot(pcpdata,labels, 'labelorientation','inline','notch','off','positions',boxPositions,'widths',0.4*increment); %'labelorientation','inline');
hold on;
plot(boxPositions, noiseFloorAtoms,'gx','MarkerSize',8);
plot(boxPositions, noiseMeanAtoms, 'mx','MarkerSize',8);
plot(boxPositions, meanAtoms,'ks','MarkerSize',12,'LineWidth',1);
plotfixer2(16,16,16,16);

monPos = get(0,'MonitorPositions');
set(gcf,'Position',[0 800 1000 800]);
markerNumber = 1;
n = 0;
if markerNumber == 1
    for i = 1:nSamples
        for j = 1:nPcps(i)
            n = n +1;
%             if bigParts{i}(j)
%                 text(X(n)+J(n),Y(n),num2str(pcpnumber(n))); %,'BackgroundColor','w');
%             else
                if pcpnumber(n) == 8
                    text(X(n)+J(n),Y(n),num2str(pcpnumber(n)),'BackgroundColor','y');
                else
                    text(X(n)+J(n),Y(n),num2str(pcpnumber(n)),'BackgroundColor','w');
                end
%             end 
        end
    end
else
    plot(X+J,Y,'ko','MarkerSize',4) %,'MarkerFaceColor','k');
end

    
atomsYLim = [2e4 1e8];

set(gca,'YScale','Log','YLim',atomsYLim,'XLim',[-increment increment*nSamples]);
ylabel('Precipitated Copper Atoms');
xlabel('Sample');
title(sprintf('Precipitated Copper Distribution -- Background %s %s Sigma', bkgdAnalysis, num2str(nSigma)));

constants;
plot(get(gca,'XLim'),[detLimitAtoms detLimitAtoms],'k:');
myezaxis2;

% print(gcf,'-dpng', sprintf('BoxPlot%s%dSigs',bkgdAnalysis,nSigma)); 
    
end

% 
% boxplot(pcpdata,labels, 'notch','off','positions',boxPositions,'widths',0.4*increment); %'labelorientation','inline');
% hold on;
% plot(boxPositions, noiseFloorAtoms,'gx','MarkerSize',8);
% plotfixer2(16,16,16,16);
% plot(X+J,Y,'ko','MarkerSize',4) %,'MarkerFaceColor','k');
% 
% atomsYLim = [2e4 1e7];
% 
% set(gca,'YScale','Log','YLim',atomsYLim,'XLim',[0 increment*nSamples]);
% ylabel('Precipitated Iron Atoms');
% xlabel('Sample');
% title('Precipitated Iron Distribution');


