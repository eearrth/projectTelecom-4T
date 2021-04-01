function [fig1] = keo_plot(alt1,Year,month,day,Data_path,function_path)
% keogram1=nan(length(alt1.data)-2,8);
% keogram2=nan(length(alt2.data)-2,8);
fig1=figure(3)
filename=[Year month day '.faifb8p16n1.pwr1.csv'];
VHF_data_pw_n1data = importdata_pw1_n1_data(filename,Data_path);

cd(function_path)
filename=[Year month day '.faifb8p16n2.pwr1.csv'];
VHF_data_pw_n2data =importdata_pw1_n1_data(filename,Data_path);

%create empty matrix for keogram
keogram1=nan(length(VHF_data_pw_n1data)-2,8);
keogram2=nan(length(VHF_data_pw_n2data)-2,8);
Eastward_1=nan(1,8);
Eastward_2=nan(1,8);
range1=nan(1,8);
range2=nan(1,8);
%% file name of csv file (from n=1)
for beam =1:8
    if beam ==1
filename_pwr_n1 = [Year month day '.faifb8p16n1.pwr1.csv'];
azi=125;
zen=37.5;
    elseif beam==2
filename_pwr_n1 = [Year month day '.faifb8p16n1.pwr2.csv'];
azi=137;
zen=30.9;
    elseif beam==3
filename_pwr_n1 = [Year month day '.faifb8p16n1.pwr3.csv'];
azi=151;
zen=26.6;
    elseif beam ==4
filename_pwr_n1 = [Year month day '.faifb8p16n1.pwr4.csv'];
azi=165;
zen=24.5;
    elseif beam ==5
filename_pwr_n1 = [Year month day '.faifb8p16n1.pwr5.csv'];
azi=180;
zen=23.8;
    elseif beam ==6
filename_pwr_n1 = [Year month day '.faifb8p16n1.pwr6.csv'];
azi=195;
zen=24.7;
    elseif beam ==7
filename_pwr_n1 = [Year month day '.faifb8p16n1.pwr7.csv'];
azi=209;
zen=27.2;
    elseif beam ==8
filename_pwr_n1 = [Year month day '.faifb8p16n1.pwr8.csv'];
azi=223;
zen=32.1;
    end

%% read data from csv file by function
cd(function_path)
VHF_data_pw1_n1data = importdata_pw1_n1_data(filename_pwr_n1,Data_path);
cd(function_path)
VHF_data_pw1_n1date  = datetime_datapw_n1(filename_pwr_n1,Data_path);
cd(function_path)

%% check -999 in data csv
VHF_data_pw1_n1=nan(size(VHF_data_pw1_n1data));
for i =1:length(VHF_data_pw1_n1data)
    for j=1:length(VHF_data_pw1_n1data(1,:))
        if VHF_data_pw1_n1data(i,j) == -999
           VHF_data_pw1_n1(i,j)=nan; 
        else
            VHF_data_pw1_n1(i,j)=VHF_data_pw1_n1data(i,j);
        end
    end
end
timedata=table2array(VHF_data_pw1_n1date(:,2));
time_data=datevec(timedata);
secofday_data=nan(length(time_data),1);
for j =1:length(time_data)
      secofday_data(j,1)=time_data(j,4).*60.*60+time_data(j,5).*60+time_data(j,6);
end
col = find(VHF_data_pw1_n1data(2,:) < 352 & VHF_data_pw1_n1data(2,:) >348);
keogram1(:,beam)=VHF_data_pw1_n1(3:end,col(1));
range1=VHF_data_pw1_n1(1,col(1));
Eastward_1(beam)= range1*sin(azi*pi/180)*sin(zen*pi/180);

end
% keogram1= flipud(keogram1);
contourf(Eastward_1,1:length(secofday_data(:)),keogram1 ,'edgecolor','none')
caxis([-10 50])
c = colorbar;
xlabel('Eastward distabce (Km)')
ylabel('UT')
c.Label.String = 'SNR (dB)';
title([Year month day 'EAR faifb8p16m1 alt=350km'])
range = 0:5:70;
contourcmap('parula',range)
first1 = datetime(2006,12,1,12,0,0,'InputFormat','MM/dd/yyyy H:m:s','Format',' HH:mm:ss');
last1 = datetime(2006,12,1,19,0,0,'InputFormat','MM/dd/yyyy H:m:s','Format',' HH:mm:ss');
xoptions1  = linspace(first1,last1,round(alt1.row/100));
date1 = datestr(xoptions1);
date1_plot=date1(:,13:20);
set(gca,'YTick',1:100:alt1.row,'YTickLabels',date1_plot)

end




