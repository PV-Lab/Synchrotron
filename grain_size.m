%Try to analyze grain size, same procedure outlined online for MATLAB
clear all; close all; clc; 
%step 1: read image
filename = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\Simulation\GCLS3_noSDE_001.tif'; 

I = imread(filename); 

figure;
imshow(I); 
title('grayscale image');

%step 2: use gradient magnitude as segmentation function
hy = fspecial('sobel'); 
hx = hy'; 
Iy = imfilter(double(I),hy,'replicate'); 
Ix = imfilter(double(I),hx,'replicate'); 
gradmag = sqrt(Ix.^2+Iy.^2); 
figure;
imshow(gradmag,[]); 
title('Gradient magnitude'); 

L = watershed(gradmag);
Lrgb = label2rgb(L);
figure, imshow(Lrgb), title('Watershed transform of gradient magnitude (Lrgb)')

% %step 3: mark foreground objects
% se = strel('disk',20); 
% Io = imopen(I,se); 
% figure;
% imshow(Io); 
% title('opening (Io)'); 
% Ie = imerode(I,se); 
% Iobr = imreconstruct(Ie,I); 
% figure;
% imshow(Iobr); 
% title('opening-by-reconstruction (Iobr)'); 
% Ioc = imclose(Io,se); 
% figure;
% imshow(Ioc); 
% title('Opening-closed (Ioc)'); 
% Iobrd = imdilate(Iobr, se);
% Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
% Iobrcbr = imcomplement(Iobrcbr);
% figure
% imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)');
% fgm = imregionalmax(Iobrcbr);
% figure
% imshow(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)');
% I2 = I;
% I2(fgm) = 255;
% figure
% imshow(I2), title('Regional maxima superimposed on original image (I2)');
% se2 = strel(ones(5,5));
% fgm2 = imclose(fgm, se2);
% fgm3 = imerode(fgm2, se2);
% fgm4 = bwareaopen(fgm3, 20);
% I3 = I;
% I3(fgm4) = 255;
% figure
% imshow(I3)
% title('Modified regional maxima superimposed on original image (fgm4)');
% 
% %Step 4: compute background markers
% bw = imbinarize(Iobrcbr);
% figure
% imshow(bw), title('Thresholded opening-closing by reconstruction (bw)'); 
% 
% D = bwdist(bw);
% DL = watershed(D);
% bgm = DL == 0;
% figure
% imshow(bgm), title('Watershed ridge lines (bgm)');
% 
% %step 5: compute watershed transform of segmentation function
% gradmag2 = imimposemin(gradmag, bgm | fgm4);
% L = watershed(gradmag2);
% 
% %step 6: visualize
% I4 = I;
% I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;
% figure
% imshow(I4)
% title('Markers and object boundaries superimposed on original image (I4)')

