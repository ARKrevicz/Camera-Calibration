clear all
close all
clc

capture=1;

if capture==1
    cam_list=webcamlist;
    m=size(cam_list);
    Rcam=webcam(1);
    Rcam.Resolution='640x480';
    preview(Rcam)
    for i=2
        if strcmp(i,'space')==1
            hold off;
            break;  
        end
    img1=snapshot(Rcam);
    imwrite(img1,'testeca3.png');  
    end
end
%==========================================================================
I = imread('testeca3.png');
%I = imread('calibrar.png');
Ibw = im2bw(I,0.7);
imshow(Ibw)
Ifill = imfill(Ibw,'holes');
Iarea = bwareaopen(Ifill,300);
Ifinal = bwlabel(Iarea);
stat = regionprops(Ifinal,'boundingbox');
imshow(I); hold on;
for cnt = 1 : numel(stat)
    bb = stat(cnt).BoundingBox;
    rectangle('position',bb,'edgecolor','r','linewidth',2);
end

props = regionprops(Ifinal, 'all');
%==========================================================================
%A=imread('testecal.png');
%A=im2bw(A);
%imshow(A);

%Measuring
h=imdistline(gca);
api=iptgetapi(h);
pause();
%
dist=api.getDistance();
u=menu('Choose Measuring unit','Pixels','Milimeters','Centimeters');

if(u==1)
    fprintf('The length of the object is: %0.2f Pixels\n',dist)
elseif(u==2)
    dist_mm=dist*(2/300);
    fprintf('The length of the object is: %0.2f cm\n',dist_mm)
else
    dist_cm=dist*(2/300)/100;
    fprintf('The length of the object is: %0.2f m\n',dist_cm)
end

delete(Rcam)
close all