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