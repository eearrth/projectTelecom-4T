function fig = contour_plot(lat_new1,lat_new2,lon_new1,lon_new2,alt1,alt2)
close all;
fig = figure(1)
lat_plot                                                 = nan(alt1.col,16);
lon_plot                                                = nan(alt1.col,16);
data_plot                                              = nan(alt1.col,16);
filename = ['fan_plot.gif']
idw=1;
first1 = datetime(2006,12,1,12,0,0,'InputFormat','MM/dd/yyyy H:m:s','Format',' HH:mm:ss');
last1 = datetime(2006,12,1,19,0,0,'InputFormat','MM/dd/yyyy H:m:s','Format',' HH:mm:ss');
xoptions1  = linspace(first1,last1,alt1.row);
time=datestr(xoptions1);
time=time(:,13:20);
for i = 1:alt1.row
    data_plot(:,1)                              = alt1.data(i,:)';
    data_plot(:,2)                              = alt1.data(i+alt1.row,:)';
    data_plot(:,3)                              = alt1.data(i+alt1.row*2,:)';
    data_plot(:,4)                              = alt1.data(i+alt1.row*3,:)';
    data_plot(:,5)                              = alt1.data(i+alt1.row*4,:)';
    data_plot(:,6)                              = alt1.data(i+alt1.row*5,:)';
    data_plot(:,7)                              = alt1.data(i+alt1.row*6,:)';
    data_plot(:,8)                              = alt1.data(i+alt1.row*7,:)';
    data_plot(:,9)                              = alt1.data(i,:)';
    data_plot(:,10)                            = alt2.data(i+alt2.row,:)';
    data_plot(:,11)                            = alt2.data(i+alt2.row*2,:)';
    data_plot(:,12)                            = alt2.data(i+alt2.row*3,:)';
    data_plot(:,13)                            = alt2.data(i+alt2.row*4,:)';
    data_plot(:,14)                            = alt2.data(i+alt2.row*5,:)';
    data_plot(:,15)                            = alt2.data(i+alt2.row*6,:)';
    data_plot(:,16)                            = alt2.data(i+alt2.row*7,:)';
    lat_plot (:,1)                                = lat_new1.b1(i,:)';
    lat_plot (:,2)                                = lat_new1.b2(i,:)';
    lat_plot (:,3)                                = lat_new1.b3(i,:)';
    lat_plot (:,4)                                = lat_new1.b4(i,:)';
    lat_plot (:,5)                                = lat_new1.b5(i,:)';
    lat_plot (:,6)                                = lat_new1.b6(i,:)';
    lat_plot (:,7)                                = lat_new1.b7(i,:)';
    lat_plot (:,8)                                = lat_new1.b8(i,:)';
    lat_plot (:,9)                                = lat_new2.b1(i,:)';
    lat_plot (:,10)                              = lat_new2.b2(i,:)';
    lat_plot (:,11)                              = lat_new2.b3(i,:)';
    lat_plot (:,12)                              = lat_new2.b4(i,:)';
    lat_plot (:,13)                              = lat_new2.b5(i,:)';
    lat_plot (:,14)                              = lat_new2.b6(i,:)';
    lat_plot (:,15)                              = lat_new2.b7(i,:)';
    lat_plot (:,16)                              = lat_new2.b8(i,:)';
   lon_plot (:,1)                                =lon_new1.b1(i,:)';
   lon_plot (:,2)                                =lon_new1.b2(i,:)';
   lon_plot (:,3)                                =lon_new1.b3(i,:)';
   lon_plot (:,4)                                =lon_new1.b4(i,:)';
   lon_plot (:,5)                                =lon_new1.b5(i,:)';
   lon_plot (:,6)                                =lon_new1.b6(i,:)';
   lon_plot (:,7)                                =lon_new1.b7(i,:)';
   lon_plot (:,8)                                =lon_new1.b8(i,:)';
   lon_plot (:,9)                                =lon_new2.b1(i,:)';
   lon_plot (:,10)                              =lon_new2.b2(i,:)';
   lon_plot (:,11)                              =lon_new2.b3(i,:)';
   lon_plot (:,12)                              =lon_new2.b4(i,:)';
   lon_plot (:,13)                              =lon_new2.b5(i,:)';
   lon_plot (:,14)                              =lon_new2.b6(i,:)';
   lon_plot (:,15)                              =lon_new2.b7(i,:)';
   lon_plot (:,16)                              =lon_new2.b8(i,:)';
   contourf(lon_plot,lat_plot,data_plot,'edgecolor','none')
    hold on 
c=colorbar;
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
C = load('coast');
plot(C.long,C.lat,'k')
xlim([95 106])
ylim([-15 20])
ylabel('Latitude')
xlabel('Longitude') 
title(['Fan plot plasmabubble time = ' time(i,:)])
 drawnow
frame = getframe(1);
im{idw} = frame2im(frame);
[A,map] = rgb2ind(im{idw},256);
        if idw == 1
           imwrite(A,map,filename,'gif','LoopCount',Inf,'delay',0.001);
        else
            imwrite(A,map,filename,'gif','WriteMode','append','delay',0.001);
        end
idw=idw+1;
end

