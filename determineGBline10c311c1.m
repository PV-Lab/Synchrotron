%%% Calculate the GB line
global pon
 %Elastic map - edge detection of GB 
    cutoff = 5;
%     GBedge   = edge(elasticCounts(stIdx:end-endIdx,:), 'Sobel');
    GBedge   = edge(elasticCounts(cutoff:end-cutoff,:), 'Sobel');
    
    
    GBregion = figure('Name','GB region'); 
    imagesc(flipud(GBedge)); axis equal;

% Manual GBLine

    
 if options.manualgbline == 'y'
     
     if exist('cursor_info','var') 
         redoGBline = input('Redo manual GB line? (y/n) ' , 's');
     
         if redoGBline == 'y'
            %Manually determine GB line

                figure(elasticMap);
                datacursormode on;

                %click on two points, export 
                uiwait(msgbox(sprintf(['1. Go to figure, click on first data point at lower left' ...
                '\n 2. click for new data point, and fix to upper right point  '...
                '\n 3. Export to "cursor_info" \n 4. then click ok'])));

         end
     else
         %Manually determine GB line

                figure(elasticMap);
                datacursormode on;

                %click on two points, export 
                uiwait(msgbox(sprintf(['1. Go to figure, click on first data point at lower left' ...
                '\n 2. click for new data point, and fix to upper right point  '...
                '\n 3. Export to "cursor_info" \n 4. then click ok'])));
     end
         
     [point1, point2] = cursor_info.Position;
     [GBx, flipudGBline,  elasticValue]    = improfile(elasticCounts,[point1(1) point2(1)], [point1(2) point2(2)]);
     
     GBline = m - flipudGBline;
     
    figure(elasticMap); hold on;  plot(GBx, flipudGBline,'g'); %plot(GBx, m-GBy, 'c+')  % AEM plot GB line
    
    if pon == 1
        pause % AEM
    end
    
    figure(elasticSurf); hold on;plot(GBx, GBline,'b'); %plot(GBx, GBy, 'r+')  % AEM plot GB line
    
    if pon == 1
        pause % AEM
    end
    
    GBy = GBline;
    GBstart = GBline;
    
    %% Fit GB with a spline

    %Fit a curve to the grain boundary in order to calculate the distance of
    %particles to that grain boundary
    
    if N > 1
        [P, S] = polyfit(GBx, GBy, N);
    else
        [P, S] = robustfit(GBx, GBy);
        P = flipud(P);
    end
    
    domain = GBx;
    
    GBline = zeros(length(domain),1);
    slopeGBline = zeros(length(domain),1);
    
    for i =1:(N+1)
        GBline = GBline + P(i)*domain.^(N+1-i);
        if N-i >= 0
        slopeGBline = slopeGBline + (N+1-i)*P(i)*domain.^(N-i);
        end
    end
    
    %flip ud the GBline
    flipudGBline = m - GBline; %since its a full 60 pixels
    flipudGBstart= m - GBstart;
    flipudslopeGBline = -1*slopeGBline;

    figure(elasticMap); hold on;  plot(domain, flipudGBline,'k'); plot(GBx, m-GBy, 'c+') % AEM plot more stuff
    
    if pon == 1
        pause % AEM
    end
    
    figure(elasticSurf); hold on;plot(domain, GBline,'g'); plot(GBx, GBy, 'r+') % AEM plot more stuff
    
    if pon == 1
        pause % AEM'
    end
    
 else
%% ---------------    Determine the GB line   ---------------------
    
    % Determine the start of the GB
    GBstart = -1*ones(1,n);
    GBedgeLinescan = cell(1,n);
    
    figure(GBregion);
    
    for i = 1:n
        
       
        %(A) edge detection from 1D elastic line scan 
%         GBedge2{i} = edge(elasticLinescan{i}, 'Sobel');
%         GBedgeLinescan{i} = GBedge2{i};
%         
        %(B) edge detection from 2D GBedge allowing for horizontal and vertical
        %filtering
        GBedgeLinescan{i}    = GBedge(:,i)'; %line scan from 2D edge detection
        
        % (C) 15% value deviation
        
        
        %DETERMINE THE START OF THE GRAIN BOUNDARY 
        j =1;
        if any(GBedgeLinescan{i})  %check to make sure an edge was detected
            while GBstart(i) < 0 && j <= m
                if GBedgeLinescan{i}(j) == 1
                    if j > 3, GBstart(i) = j-2; else GBstart(i) = j; end %a little leeway
                else
                    j = j+1;
                end
            end
        else
            GBstart(i) = 0;
        end
        
    end   
    
  
    
    %Exclude the zero values
    GBx = []; GBy = [];
    for i = 1:n
        if GBstart(i)>5 && GBstart(i)<n-5
            GBx = [GBx i];
            GBy = [GBy GBstart(i)];
        end
    end
    

%% Determine the end of the GB
    
    GBend   = m;
    
    
     
%% Fit GB with a spline


    %Fit a curve to the grain boundary in order to calculate the distance of
    %particles to that grain boundary
    
    polyFitBoundaries = {'Fe53bAG' 'Fe53mAG' 'Fe200bAG' 'Fe53mPDG'};
    
    if ~isempty(strfind(map.title,'53')) || ~isempty(strfind(map.title,'200'))
        
        disp('Hard coded GB fit in use for I2Eb sample');
        
        if any(any(strcmp(map.title, polyFitBoundaries))) 
            N = 3;
        else
            N = 1;
        end
    end
            
    if N > 1
        [P, S] = polyfit(GBx, GBy, N);
    else
        [P, S] = robustfit(GBx, GBy);
        P = flipud(P);
    end
    
    domain = (1:n)';
    
    map.GBline = zeros(n,1);
    slopeGBline = zeros(n,1);
    
    for i =1:(N+1)
        map.GBline = map.GBline + P(i)*domain.^(N+1-i);
        if N-i >= 0
        slopeGBline = slopeGBline + (N+1-i)*P(i)*domain.^(N-i);
        end
    end
    
    %flip ud the GBline
    flipudGBline = m - map.GBline; %since its a full 60 pixels
    flipudGBstart= m - GBstart;
    flipudslopeGBline = -1*slopeGBline;
    
    figure(elasticMap); hold on;
    % AEM Comment out - just don't show the GB line fit   
    plot(domain, flipudGBline,'k'); 
    
    if pon == 1
        pause % AEM
    end
    
    plot(GBx, m-GBy, 'c+') % plot the raw data for fitting the GB line
    if pon == 1
        pause % AEM
    end
    
    figure(elasticSurf); hold on;plot(domain, map.GBline,'g'); plot(GBx, GBy, 'r+') 
    if pon == 1
        pause % AEM
    end
 end  
 
 
 