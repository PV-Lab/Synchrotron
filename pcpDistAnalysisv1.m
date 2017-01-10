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

function [map] = pcpDistAnalysisv1(map,varargin)
%Analyzing the high temperature diffusion samples from 2010c3 and 2011c1

global pon xLocation yLocation

% function GBanalysis
%GB angle and depth analysis

%ONLY GBDOMAIN FOR PRECIPITATE DENSITY, NOT THE WHOLE MAP HEIGHT

%Normal line scans
%Precipitate size
%Precipitate density
%Vogt's processing paper



    % load mapsAllSamplesBkgdSubtracted;
    %image flips the map upside down (Ydir, 'reverse')
    
    %High elastic scattering grain should be at the bottom

    
%% Set analysis parameters
% AEM COMMENT OUT TO KEEP NOISE MAPS OPEN close all;
%disp(map)

% define defaults at the beginning of the code so that you don't need to scroll
% way down in case you want to change something or if the help is incomplete
options = struct('channel','Ni','scaling','on','background','removed','fitorder','1','manualgbline','n','plots','on','plotScale','linear'); %,'secondparameter',magic(3));

%scaling - on/off toggles the scaling of cts with depth from GB
%backgrond - 
%  'removed' means fit and removed,
%  'subtracted' means fit and subtracted from all data, 
%  'none' means no adjustment after Barry

% AEM check and pair the propertyName and propertyValue pairs for the
% options
if ~isstruct(varargin{1})
    % read the acceptable names
    optionNames = fieldnames(options); % AEM fieldnames refers to structure fields

    % count arguments
    nArgs = length(varargin);
    if round(nArgs/2)~=nArgs/2
       error('Analysis options needs propertyName/propertyValue pairs')
    end

    for pair = reshape(varargin,2,[]) % pair is {propName;propValue}
       inpName = lower(pair{1}); % make case insensitive

       if any(strcmp(inpName,optionNames))
          %# overwrite options. If you want you can test for the right class here
          %# Also, if you find out that there is an option you keep getting wrong,
          %# you can use "if strcmp(inpName,'problemOption'),testMore,end"-statements
          options.(inpName) = pair{2};
       else
          error('%s is not a recognized parameter name',inpName)
       end
    end
else
    options = varargin{1};
end

% AEM display the options
disp(options)

if pon == 1
    pause % AEM
end
% ACCOUNT FOR VARIOUS OPTIONS
elasticCounts = map.s_e.counts;

% AEM choose the right element channel
if strcmp(options.channel,'Ni')
    map = map.Ni;
elseif strcmp(options.channel,'only Ni') %if only Cr has been imported and fitted
    map = map;
else
    map = map.(options.channel);
end

% AEM choose the data with the chosen background treatment

rawCounts = map.counts; % AEM this is used - don't comment it out!
if strcmp(options.background,'none')
    counts = map.counts;
elseif strcmp(options.background,'removed')
    counts = map.countsNoBkgd; %Not Subtracted; check effect of background subtraction
elseif strcmp(options.background,'nSigmaSubtracted')
    counts = map.countsBkgdSigmaSubtracted;
else
    counts = map.countsBkgdSubtracted;
end
   
[m, n] = size(counts); 
 
%order of GBline fit
N = str2double(options.fitorder); %linear fit
% disp('Order of GB fit'); disp(N);
    
     
 %% Set constants
 
    constants; % AEM these are synchrotron beamline setup constants
    
    %%  Determine the scattering values in the bulk from elastic channel
    
%     elasticBulkLevels;
        
%% Intro Plots

    % AEM make the horizontal line, the sample name in all caps, then another
    % horizontal line in the command window

    fprintf('\n %s \n', char(95*ones(1,length(map.title))));
    fprintf('\n %s \n', upper(map.title));
    fprintf(' %s \n', char(95*ones(1,length(map.title))));
    
    if strcmp(options.plots,'on')
        if pon == 1
            pause % AEM
        end
        
        initialPlots10c1; %plot the elastic map and surface and the chromium map
        
        if pon == 1
        pause % AEM
        end
    end
    
    
%% ---------------    Determine the GB line   ---------------------
    
     
       determineGBline10c311c1;
       
   if  strcmp(options.scaling,'on')
   
        % Calculate the GB ANGLE w.r.t. SURFACE
    
        calculateGBangle10c311c1;   % AEM this doesn't exist yet - ask DPF
%     GBangleD = 60;
    else
        disp('Skipping GB angle fit, because no scaling...');
    end
%% ------------------------  Cru PARTICLE ISOLATION -----------------------

    detectParticles10c1; 
    %detects particles and if plots on, plots bounding boxes on Cr Map and creates new chromium detected map
    
%% Calculate particle-GB distance and particle depth
    if strcmp(options.scaling,'on')
        calculateParticleDepth10c1;
    else
        disp('And not calculating particle depth...')
    end
    
    %% Scale Counts to Surface
    %uses a scale factor of 1 if no scaling is on
    if pon == 1
        pause % AEM
    end
    
    scaleCountswDepth10c1;
    
    if pon == 1
        pause % AEM
    end
    
%% CALCULATE PRECIPITATE SIZE

    calculatePrecipitateSize10c1;
    if pon == 1
    pause % AEM
    end
    
%% CALCULATE PRECIPITATE DENSITY 

    calculatePrecipitateDensityv2;
    if pon == 1
    pause % AEM
    end
    
%% OUTPUTS

   
   %organized left to right according to centroids
 
    fprintf('\n N particles: \t\t %f \n', Npcps);
    fprintf(' Avg. pcp radius: \t %2.3e \n', map.meanPartRadj);
%     fprintf(' GB pcp Density: \t %2.3e \n', map.lineDensityPcpsInvUm);
%     Commented by MAJ to allow reporting of x, y locations
  
    
    if strcmp(options.plots,'on')
        if ~strcmp(options.scaling,'on')
            particleDist = ones(1,Npcps);
            particleDepth = ones(1,Npcps);
        end
        
        %particleData = [particleDist', particleDepth', map.particleRadiusAdj' ,map.particleN_Cr_atomsAdj', map.lineDensityPcpsInvUm*ones(Npcps,1)];
        
        %particleData = [xLocation',yLocation',particleDist', particleDepth', map.particleRadiusAdj' ,map.particleN_Cr_atomsAdj', map.lineDensityPcpsInvUm*ones(Npcps,1)];
%         particleData = [xLocation',yLocation',particleDist', particleDepth', map.particleRadiusAdj' ,map.particleN_Cu_atomsAdj'];
        particleData = [xLocation',yLocation', map.particleRadius' ,map.particleN_Cu_atoms'];
        table = figure('Name','Calculated Particle Properties');
        pos   = get(gcf, 'Position'); width = pos(3); height= pos(4);
        %cnames = {'Dist from GB (um)','Depth (um)', 'Radius (nm)', 'N_Cr_atoms', 'Pcp Density'};

        %cnames = {'X location','Y location','Dist from GB (um)','Depth (um)', 'Radius (nm)', 'N_Cr_atoms', 'Pcp Density'};
        cnames = {'X location','Y location','Dist from GB (um)','Depth (um)', 'Radius (nm)', 'N_Cu_atoms'};
        t = uitable('Parent',table,'Data',particleData,'ColumnName',cnames,'Position', [0 0 width height]);

        radiusDepth = figure('Name', 'Pcp Radius vs Particle Depth'); 
%         plot(particleDepth',map.particleRadiusAdj','o')
        hold on;
%         for i = 1:length(particleDepth)
%             text(particleDepth(i),map.particleRadiusAdj(i),num2str(i),'BackgroundColor','w');
%         end


        binSize = 2*iqr(map.particleRadius)/length(map.particleRadius)^(1/3);  %Freedman-Diaconis
        nBins = (max(map.particleRadius)-min(map.particleRadius))/binSize;
        histRadius = figure('Name', 'Histogram of Pcp Radii'); hist(map.particleRadius);

        %% FIGURE MAINTENANCE:

        scrsz = get(0,'ScreenSize'); 
        pos = get(gcf,'OuterPosition');
        width = pos(3);
        height= pos(4);




       % Add GB line to all figures

        %Plot the grain boundary line on all pertinent figures
       if strcmp(options.scaling, 'on')
        figure(scaledCu);   hold on;  plot(domain, GBline,'g'); shading flat;
        figure(GBregion);   hold on;  plot(domain, flipudGBline,'g'); plot(domain, flipudGBstart,'co');
    %     figure(pcps);       hold on;  plot(domain, flipudGBline,'g');


        figure(CuMap);      hold on;  plot(domain, GBline,'g'); shading flat; axis equal;
       end
%        figure(rawMap);
        
        
    end
   %     set(scaledCr, 'OuterPosition',       [1          scrsz(4)-height   width height]);
%     set(table, 'OuterPosition',          [1          scrsz(4)-height*2 width height]);
%     set(CrMap, 'OuterPosition',          [1+width       scrsz(4)-height   width height]);
%     set(distMap, 'OuterPosition',        [1+width    scrsz(4)-height*2 width height]);
%     set(elasticMap, 'OuterPosition',     [1+2*width 	scrsz(4)-height   width height]);
%     set(lineScans, 'OuterPosition',      [1+2*width	scrsz(4)-height*2 width height]);
%     set(CrPts, 'OuterPosition',          [1+3*width 	scrsz(4)-height   width height]);
%     set(scalingFactors,'OuterPosition',  [1+3*width	scrsz(4)-height*2 width height]);
%     set(histTheta, 'OuterPosition',      [1         scrsz(4)-height*3 width height]);
%     set(pcps,'OuterPosition',            [1+width    scrsz(4)-height*3 width height]);
%     set(GBregion, 'OuterPosition',       [1+2*width    scrsz(4)-height*3 width height]);
%     
    
% calcRotAngle;
% 
%     [q r ] = size(map.elastic.counts);
%     
%     A = [cos(rotationTheta) sin(rotationTheta); -sin(rotationTheta) cos(rotationTheta)];  %clockwise rotation
% 
%     for j = 1:r
%         for i = 1:q
%             x   = [j i]';
%             xhat= A*x;
%             rX(i,j)  = xhat(1);
%             rY(i,j)  = xhat(2);
%             rZ(i,j)  = map.elastic.counts(i,j);
%             
%             newX = round(xhat(1));
%             if newX == 0, newX = 1; end
%             newY = round(xhat(2));
%             if newY == 0, newY = 1; end
%             
%             eval('Rot(newX,newY) = map.elastic.counts(i,j);');
%         end
%     end
% 
%     RotatedPlot = figure('name', sprintf('Rotation by pi/%d',1/(rotationTheta/pi)));
%     surf(rX, rY, rZ); 
%     size_factor = 0.5;
%     scrsz = get(0,'ScreenSize');
%     set(gcf, 'Position',[1 scrsz(4)*size_factor scrsz(3)*size_factor scrsz(4)*size_factor]); 
%     view(2); 
%   
%     figure; imagesc(Rot)
%   figure; J = imrotate(map.elastic.counts, rotationTheta); imagsc(J)

    