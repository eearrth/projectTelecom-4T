function [fig1,fig2] = alt_plot(alt1,alt2,Year,month,day)
%%%% for n=1

first1 = datetime(2006,12,1,12,0,0,'InputFormat','MM/dd/yyyy H:m:s','Format',' HH:mm:ss');
last1 = datetime(2006,12,1,19,0,0,'InputFormat','MM/dd/yyyy H:m:s','Format',' HH:mm:ss');
xoptions1  = linspace(first1,last1,round(alt1.row/100));
date1 = datestr(xoptions1);
date1_plot=date1(:,13:20);
nx1 = length(xoptions1);
first2 = datetime(2006,12,1,12,0,0,'InputFormat','MM/dd/yyyy H:m:s','Format',' HH:mm:ss');
last2 = datetime(2006,12,1,19,0,0,'InputFormat','MM/dd/yyyy H:m:s','Format',' HH:mm:ss');
xoptions2  = linspace(first2,last2,round(alt2.row/100));
date2 = datestr(xoptions2);
date2_plot=date2(:,13:20);
nx2 = length(xoptions2);
fig1=figure(1);
subplot(4,2,1)
contourf(1:alt1.row,alt1.hight(1,:),alt1.data(1:alt1.row,1:alt1.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt1.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n1Beam=1'])

subplot(4,2,2)
contourf(1:alt1.row,alt1.hight(2,:),alt1.data(alt1.row+1:alt1.row*2,1:alt1.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt1.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n1Beam=2'])


subplot(4,2,3)
contourf(1:alt1.row,alt1.hight(3,:),alt1.data(alt1.row*2+1:alt1.row*3,1:alt1.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt1.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n1Beam=3'])

subplot(4,2,4)
contourf(1:alt1.row,alt1.hight(4,:),alt1.data(alt1.row*3+1:alt1.row*4,1:alt1.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt1.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n1Beam=4'])

subplot(4,2,5)
contourf(1:alt1.row,alt1.hight(5,:),alt1.data(alt1.row*4+1:alt1.row*5,1:alt1.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt1.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n1Beam=5'])

subplot(4,2,6)
contourf(1:alt1.row,alt1.hight(6,:),alt1.data(alt1.row*5+1:alt1.row*6,1:alt1.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt1.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n1Beam=6'])


subplot(4,2,7)
contourf(1:alt1.row,alt1.hight(7,:),alt1.data(alt1.row*6+1:alt1.row*7,1:alt1.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt1.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n1Beam=7'])

subplot(4,2,8)
contourf(1:alt1.row,alt1.hight(8,:),alt1.data(alt1.row*7+1:alt1.row*8,1:alt1.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt1.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n1Beam=8'])


fig2=figure(2);
subplot(4,2,1)
contourf(1:alt2.row,alt2.hight(1,:),alt2.data(1:alt2.row,1:alt2.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt2.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n2Beam=1'])

subplot(4,2,2)
contourf(1:alt2.row,alt2.hight(2,:),alt2.data(alt2.row+1:alt2.row*2,1:alt2.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt2.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n2Beam=2'])


subplot(4,2,3)
contourf(1:alt2.row,alt2.hight(3,:),alt2.data(alt2.row*2+1:alt2.row*3,1:alt2.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt2.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n2Beam=3'])

subplot(4,2,4)
contourf(1:alt2.row,alt2.hight(4,:),alt2.data(alt2.row*3+1:alt2.row*4,1:alt2.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt2.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n2Beam=4'])

subplot(4,2,5)
contourf(1:alt2.row,alt2.hight(5,:),alt2.data(alt2.row*4+1:alt2.row*5,1:alt2.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt2.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n2Beam=5'])

subplot(4,2,6)
contourf(1:alt2.row,alt2.hight(6,:),alt2.data(alt2.row*5+1:alt2.row*6,1:alt2.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt2.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n2Beam=6'])


subplot(4,2,7)
contourf(1:alt2.row,alt2.hight(7,:),alt2.data(alt2.row*6+1:alt2.row*7,1:alt2.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt2.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n2Beam=7'])

subplot(4,2,8)
contourf(1:alt2.row,alt2.hight(8,:),alt2.data(alt2.row*7+1:alt2.row*8,1:alt2.col)','edgecolor','none')
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
set(gca,'XTick',1:100:alt2.row,'XTickLabels',date1_plot)
title([Year month day 'EAR faifb8p16n2Beam=8'])

end

