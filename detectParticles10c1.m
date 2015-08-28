%% detectParticles10c1.m
global pon xLocation yLocation
%%

    %Detect the edges in the Fe Map as particles
    
    % Fe Counts or Fe edges.....
    CC = bwconncomp(counts,4);  %this is treated as an image so Y-dir is reversed
    
%     %MAJ added - save the x and y locations of each particle
    xLocation = zeros(1,1); 
    yLocation = zeros(1,1); 
    partList = CC.PixelIdxList; 
    for i = 1:length(partList)
        [m,n] = size(partList{i});
        if m~=1
            part = partList{i};
            x = 0; y = 0; 
            for j = 1:m
                x = x+map.xValue(part(j));
                y = y+map.yValue(part(j)); 
            end
            xLocation(i) = x/m; 
            yLocation(i) = y/m; 
        else
            xLocation(i) = map.xValue(partList{i}); 
            yLocation(i) = map.yValue(partList{i});
        end
    end

    %Label each particle uniquely
    L = labelmatrix(CC);
%     RGB = label2rgb(L);
%     %Show all particles with their unique color label
%     figure, imshow(RGB)
    
    %Calculate the centroid of each Fe particle and plot of Fe particle map
    s  = regionprops(CC, 'centroid','BoundingBox','PixelList');
    centroids = cat(1, s.Centroid);
    map.s= s;
    
    nBigParts = 0;
    nBigPartsIdx = [];
    for i = 1:length(s)
        [ AA BB] = size(map.s(i,1).PixelList);
        if AA > 1
            nBigParts = nBigParts+1;
            nBigPartsIdx = [nBigPartsIdx i];
        end
    end
    
    [Nparticles poop] = size(centroids);
    
   if strcmp(options.plots,'on')

        
    %     figure(pcps); hold on;  plot(centroids(:,1), m-centroids(:,2), 'b*'); 


        figure(CrMap); hold on;

        boundingBox = cat(1, s.BoundingBox);
        if pon == 1
            pause % AEM
        end
        
        for i = 1:Nparticles

            cornerUL = [boundingBox(i,1)                    , boundingBox(i,2)];
            cornerUR = [boundingBox(i,1) + boundingBox(i,3) , boundingBox(i,2)];
            cornerLL = [boundingBox(i,1)                    , boundingBox(i,2) + boundingBox(i,4)];  %NB: Y-dir reversed
            cornerLR = [boundingBox(i,1) + boundingBox(i,3) , boundingBox(i,2) + boundingBox(i,4)];


    %         plot(cornerUL(1),cornerUL(2), 'ro');
    %         plot(cornerLL(1),cornerLL(2), 'rd');
            if find(nBigPartsIdx == i)
                color = 'c';
            else
                color = 'r';
            end

            plot([cornerUL(1) cornerUR(1)], [cornerUL(2) cornerUR(2)],[color '-'],...
                 [cornerUL(1) cornerLL(1)], [cornerUL(2) cornerLL(2)],[color '-'],...
                 [cornerLL(1) cornerLR(1)], [cornerLL(2) cornerLR(2)],[color '-'],...
                 [cornerUR(1) cornerLR(1)], [cornerUR(2) cornerLR(2)],[color '-']);

        end

        FePts = figure('Name','Chromium Detected at Pts'); hold on;
        set(gca, 'Xlim', [0 n], 'Ylim', [0 m]);

        if pon == 1
            pause % AEM
        end
        
       for i = 1:Nparticles

            cornerUL = [boundingBox(i,1)                    , boundingBox(i,2)];
            cornerUR = [boundingBox(i,1) + boundingBox(i,3) , boundingBox(i,2)];
            cornerLL = [boundingBox(i,1)                    , boundingBox(i,2) + boundingBox(i,4)];  %NB: Y-dir reversed
            cornerLR = [boundingBox(i,1) + boundingBox(i,3) , boundingBox(i,2) + boundingBox(i,4)];

    %         plot(cornerUL(1),cornerUL(2), 'ro');
    %         plot(cornerLL(1),cornerLL(2), 'rd');

            plot([cornerUL(1) cornerUR(1)], [cornerUL(2) cornerUR(2)],[color '-'],...
                 [cornerUL(1) cornerLL(1)], [cornerUL(2) cornerLL(2)],[color '-'],...
                 [cornerLL(1) cornerLR(1)], [cornerLL(2) cornerLR(2)],[color '-'],...
                 [cornerUR(1) cornerLR(1)], [cornerUR(2) cornerLR(2)],[color '-']);

       end
   end

%% END