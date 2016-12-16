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

%Intro Figures
global pon
%% Elastic and GB Edge Detected Figures  

    %Elastic map
    elasticMap = figure('Name', 'Elastic Map');  
    imagesc(flipud(elasticCounts)); colorbar; axis equal;  % AEM plot elastic counts as a 2D colored image

    elasticSurf = figure('Name','Elastic Surface'); surf(elasticCounts); % AEM plot surface of the elastic counts

  
%% Cr and Particle Edge-Detected Figures

    %Cr map
    CrMap    = figure('Name','Cr map'); surf(counts); view(2); %imagesc(flipud(counts)); % AEM plot surface of Fe counts
    
    if strcmp(options.plotScale,'log')
        rawMap  = figure('Name','Raw Data Map'); title(map.title); 
        adjRawCounts = rawCounts;
        adjRawCounts(adjRawCounts<1e-8) = 0;
        % AEM was originally surf(log(adjRawCounts))
        surf(log(adjRawCounts)); view(2); plotfixer2(16,16,16,16); axis equal; shading flat; axis tight; box on; colormap('Gray'); % AEM plot surface of raw counts 
        cLim = get(gca, 'CLim'); colorbar;
       
        
        % caxis([-7.5 -4])
       
    else
        rawMap  = figure('Name','Raw Data Map'); title(map.title); surf(rawCounts); view(2); plotfixer2(16,16,16,16); axis equal; shading flat; axis tight; box on; 
    end
    
    % AEM UNCOMMENTED START
    %Overlay the elastic map on the Fe map
    if pon == 1
        pause % AEM
    end
    
    figure(CrMap);
    
    if pon == 1
        pause % AEM
    end
    
    hold on;
    h = imagesc(flipud(elasticCounts)); hold off;
    
    if pon == 1
    pause % AEM
    end
    
    
   alpha = 0.1*ones(m,n); 
    set(h, 'AlphaDataMapping','scaled','AlphaData', gradient(flipud(counts)));
    
    figure % AEM
    
% AEM UNCOMMENTED END

    %Fe particles map - edge detection
%     particles = edge(counts,'Sobel');
%     pcps      = figure('Name', 'Fe Particles'); imagesc(flipud(particles));
%     
    