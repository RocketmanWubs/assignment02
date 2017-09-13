clc; clear all; close all;

StartingFrame = 1;
EndingFrame = 489;

Xcentroid1 = [];
Ycentroid1 = [];

Xcentroid2 = [];
Ycentroid2 = [];

for k = StartingFrame : EndingFrame-1
    clc;
    fprintf('Reading image %1.0f\n',k);
    rgb = imread(['balls/img',sprintf('%2.3d',k),'.jpg']);
    
    [BW,masked] = createMask1(rgb);
    [BW2,masked] = createMask2(rgb);
    
    SE = strel('disk',3,0);
    Iopen1 = imopen(BW,SE);
    Iclose1 = imclose(Iopen1,SE);
    
    Iopen2 = imopen(BW2,SE);
    Iclose2 = imclose(Iopen2,SE);

    [labels1,number1] = bwlabel(Iclose1,8);
    [labels2,number2] = bwlabel(Iclose2,8);
    
    if number1 > 0
        Istats1 = regionprops(labels1, 'basic', 'Centriod');
        [maxVal, maxIndex1] = max([Istats1.Area]);
        Xcentroid1 = [Xcentroid1 Istats1(maxIndex1).Centroid(1)];
        Ycentroid1 = [Ycentroid1 Istats1(maxIndex1).Centroid(2)];
    end
    
    if number2 > 0
        Istats2 = regionprops(labels2, 'basic', 'Centriod');
        [maxVal, maxIndex2] = max([Istats2.Area]);
        Xcentroid2 = [Xcentroid2 Istats2(maxIndex2).Centroid(1)];
        Ycentroid2 = [Ycentroid2  Istats2(maxIndex2).Centroid(2)];
    end
    
end
clc;
fprintf('Outputting path\n');
imshow(rgb);
hold on;
scatter(Xcentroid1, Ycentroid1,'b');
scatter(Xcentroid2, Ycentroid2,'g');