clc;clear all;close all;
%% create day and function path
d = datetime('18-Mar-2019');
time=datetime('18-Mar-2019');
time2=(time:1/86400:time+1);
time_start=time2(46201);
time_stop=time2(86401);
%  d = datetime('10-Jul-2020');
% d = datetime('07-Jun-2020'); % d = '25-Mar-2019' '4-Mar-2020' '13-Feb-2020'; change d only !
date = datevec(d);
D1 = date(:,1:3);
D2 = D1;
D2(:,2:3) = 0;
ydoy = cat(2, D1(:,1), datenum(D1) - datenum(D2));
Year = num2str(ydoy(1,1));
Year2 = num2str(D1(1)-2000);
day=num2str(D1(3),'%2d');
mth = D1(2);
month=num2str(mth,'%.2d');
doy = num2str(ydoy(1,2),'%.3d');
main_path = [pwd '\'];
file_plot = [main_path 'RTI_plot\'];
Data_path = [main_path 'DATA\' Year '\'];
function_path = [main_path 'FUNCTION'];
data_mat=[main_path 'data_mat\'];
%%% find data Althi
cd(function_path)
[~,~,~,~,~,~,alt1.data,alt2.data,alt1.hight,alt2.hight,alt1.range,alt2.range,...
    alt1.row,alt1.col,alt2.row,alt2.col ,alt1.date,alt2.date]...
    = read_data(Year,month,day,Data_path,function_path);    
cd(main_path)
alt1.data(alt1.data== -999) = nan;
alt2.data(alt2.data== -999) = nan;
first1 = datetime(str2num(Year),str2num(month),str2num(day),12,0,0,'InputFormat','MM/dd/yyyy H:m:s','Format','MM/dd/yyyy HH:mm:ss');
last1 = datetime(str2num(Year),str2num(month),str2num(day),19,0,0,'InputFormat','MM/dd/yyyy H:m:s','Format','MM/dd/yyyy HH:mm:ss');
time1  = linspace(first1,last1,round(alt1.row));
time2  = linspace(first1,last1,round(alt2.row));
%% ======================alt plot========================================================
disp('make plot ATI . . . .')
cd(function_path)
[fig1,fig2] = alt_plot(alt1,alt2,Year,month,day);
cd(file_plot)
saveas(fig1,[Year month day 'faifb8p16n1.jpg'])
saveas(fig2,[Year month day 'faifb8p16n2.jpg'])

%%  ======================find centroid point of EPB use ATI=================================  
 figure(5)
 alt1.data(alt1.data== -999) = 0;
alt2.data(alt2.data== -999) = 0;

% nx2 = length(xoptions2);
fig5=figure(5);contourf(1:alt1.row,alt1.hight(1,:),alt1.data(1:alt1.row,1:alt1.col)','edgecolor','none')
set(gca, 'Visible', 'off');
caxis([30 40])

cd(file_plot)
saveas(fig5,[Year month day 'faifb8p16n1b1.jpg'])
%==================== find centroid point=============================
I = imread([Year month day 'faifb8p16n1b1.jpg']);
i2 = rgb2gray(I);
 BW = im2bw(i2,maps,0.71);

measurements = regionprops(BW, 'Centroid');
centroids = [measurements.Centroid];
xCentroids = centroids(1:2:end);
yCentroids = centroids(2:2:end);
figure(21)
fig21=figure(21);
imshow(I);hold on
plot(xCentroids,yCentroids,'o','LineWidth',2)
cd(file_plot)
saveas(fig21,[Year month day '_centroid.jpg'])
cd(main_path)
%% per file
alt1.data(alt1.data== -999) = nan;
alt2.data(alt2.data== -999) = nan;
filename1= 'ear_faifb8p16n1_0350.txt';
filename2= 'ear_faifb8p16n2_0350.txt';
cd(function_path)
per_n1 = read_perpendicular_file_n1(filename1,main_path);
cd(function_path)
per_n2 = read_perpendicular_file_n1(filename2,main_path);
%% find lat lon at new alt with IGRF model and plot fan plot 

% range_n1                                                      = per_n1(:,1);
% althitude_n1                                                 = per_n1(:,2);
% azimuth_n1                                                  = per_n1(:,3);
% zenith_n1                                                     = per_n1(:,4);
% lat_n1_old                                                    = per_n1(:,5);
% lon_n1_old                                                   = per_n1(:,6);
% range_n2                                                      = per_n2(:,1);
% althitude_n2                                                 = per_n2(:,2);
% azimuth_n2                                                  = per_n2(:,3);
% zenith_n2                                                     = per_n2(:,4);
% lat_n2_old                                                    = per_n2(:,5);
% lon_n2_old                                                   = per_n2(:,6);
% cd(function_path)
% x=[100:1000];
% [latitude, longitude, altitude] = igrfline('18-Mar-2019 12:09:34',    -0.8650, ...
%       101.2640,   201.6, 'gd', 10,1)

pern1.beam1                                = per1_beam(filename1, 2,154);
pern1.beam2                                = per1_beam(filename1, 155,307);
pern1.beam3                                = per1_beam(filename1, 308,460);
pern1.beam4                                = per1_beam(filename1, 461,613);
pern1.beam5                                = per1_beam(filename1, 614,766);
pern1.beam6                                = per1_beam(filename1, 767,919);
pern1.beam7                                = per1_beam(filename1, 920,1072);
pern1.beam8                                = per1_beam(filename1, 1073,inf);

pern2.beam1                                = per1_beam(filename2, 2,154);
pern2.beam2                                = per1_beam(filename2, 155,307);
pern2.beam3                                = per1_beam(filename2, 308,460);
pern2.beam4                                = per1_beam(filename2, 461,613);
pern2.beam5                                = per1_beam(filename2, 614,766);
pern2.beam6                                = per1_beam(filename2, 767,919);
pern2.beam7                                = per1_beam(filename2, 920,1072);
pern2.beam8                                = per1_beam(filename2, 1073,inf);
disp('done read data from text file')
cd(function_path)

[lat_new1,lat_new2,lon_new1,lon_new2] = newlatlon(alt1,alt2,pern1,pern2);
disp('let plot with Keogram algolithm')
fig3 = keo_plot(alt1,Year,month,day,Data_path,function_path);
disp('done . . as ati plot and keogram plot')

cd(file_plot)
saveas(fig3,[Year month day 'Keoplot_faifb8p16n1.jpg'])
cd(function_path)
fig4 = contour_plot(lat_new1,lat_new2,lon_new1,lon_new2,alt1,alt2);
cd(main_path)









