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
    