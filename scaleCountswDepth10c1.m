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


%scaleCountswDepth

%for each particle scale the counts as they would appear at the surface
    %for the calculated particle depth accounting for the attenuation of
    %the incoming beam and the outgoing fluorescent signal
    
    scaleFactor   = ones(1, Nparticles);
    scaledCounts = counts;
    partScaledCounts = cell(1,Nparticles);
    partMaxCounts  =-1*ones(1, Nparticles);
    
    if strcmp(options.plots,'on')
     figure(FePts); hold on;  set(gca, 'Xlim', [0 n], 'Ylim', [0 m]);
    end
     
    
    for j = 1:Nparticles 
    
        if strcmp(options.scaling,'on')
            if particleDist(j) > 0  %choose only particles above the grain boundary to scale
           
                scaleFactor(j) = exp(-particleDepth(j)/l_10000/cos(alphaAngle))*exp(-particleDepth(j)/l_6404/cos(betaAngle));
            else
                scaleFactor(j) = 1;
                if j == 1, disp('Not scaling any counts'); end;
            end
        else
            scaleFactor(j) = 1; %otherwise assume they're on the surface
        end
        
            %for all the pixels within the particle pixel list, scale the measured
            %Fe values by the scaleFactor
            partPixelList = s(j).PixelList;

            [q r] = size(partPixelList);
            
            for k = 1:q

                scaledCounts(partPixelList(k,2), partPixelList(k,1)) = counts(partPixelList(k,2), partPixelList(k,1))/scaleFactor(j);  %need to fliplr (X, Y) to get m x n coordinates
                
                partScaledCounts{j}(k) = scaledCounts(partPixelList(k,2), partPixelList(k,1));  %the scaled counts of the pixels corresponding to the particle
                
                if strcmp(options.plots,'on')
                    plot(partPixelList(k,1),partPixelList(k,2), 'g+');
                end
            end
            
            [partMaxCounts(j) partMaxIndex]= max(partScaledCounts{j}(1:end));
            
            maxX(j) = partPixelList(partMaxIndex,1);
            maxY(j) = partPixelList(partMaxIndex,2);
            if strcmp(options.plots,'on')
                plot(maxX(j),maxY(j), 'bo');
                text(maxX(j)+2,maxY(j)+2,num2str(j),'BackgroundColor','w');

            end
       
    end
    
    scalingFactor = scaledCounts./counts;
    
%     scaledFeMap = figure('Name','Scaled Iron Counts'); surf(scaledCounts); view(2); colorbar; set(gca,'clim',[0 100]);
%     normalFeMap = figure('Name','Unscaled Iron Counts'); surf(counts); view(2); colorbar;set(gca,'clim',[0 100]);
%  

%%  NEW PLOTS
if strcmp(options.plots,'on')
    
    scalingFactors = figure('Name','Scaling Factors');
    
    imagesc(flipud(scalingFactor));  colorbar;
    
    scaledFe = figure('Name','Scaled Chromium Map');
    surf(scaledCounts); 
    view(2); colorbar; axis equal;
end
%% OUTPUTS
   
    map.scalingFactor = scalingFactor;
    map.scaledCounts = scaledCounts;