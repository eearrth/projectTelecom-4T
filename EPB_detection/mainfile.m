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

% for find the size of data  to create empty matrix
cd(function_path)
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


cd(main_path)


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
%% make plot
fig=figure(beam);
time_use=linspace(time_start,time_stop,length(secofday_data(:)))';
contourf(1:length(secofday_data(:)),VHF_data_pw1_n1(2,:),VHF_data_pw1_n1(3:end,:)','edgecolor','none')
% xlim([time_use(1) time_use(end)])
caxis([-10 50])
c = colorbar;
ylabel('Altitude (Km)')
xlabel('UT')
c.Label.String = 'SNR (dB)';
range = 0:5:70;
contourcmap('parula',range)
b=num2str(beam);
title([filename_pwr_n1 'Beam=' b])
disp(['status read from csv at n : 1==>' b])
cd(file_plot)
saveas(fig,[filename_pwr_n1 'Beam=' b '.jpg'])
cd(data_mat)
t=[filename_pwr_n1 'Beam=' b 'time.mat'];
save(t,'timedata')
d=[filename_pwr_n1 'Beam=' b 'data.mat'];
save(d,'VHF_data_pw1_n1')
cd(main_path)
end
% keogram1= flipud(keogram1);
figure(11)
contourf(Eastward_1,1:length(secofday_data(:)),keogram1 ,'edgecolor','none')
caxis([-10 50])
c = colorbar;
xlabel('Eastward distabce (Km)')
ylabel('UT')
c.Label.String = 'SNR (dB)';
title([Year month day 'EAR faifb8p16m1 alt=350km'])
range = 0:5:70;
contourcmap('parula',range)


%% file name of csv file (from n=2)
% for beam =1:8
%     if beam ==1
% filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr1.csv'];
% azi=
% zen=
%     elseif beam==2
% filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr2.csv'];
% azi=
% zen=
%     elseif beam==3
% filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr3.csv'];
% azi=
% zen=    
%     elseif beam ==4
% filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr4.csv'];
%  azi=
% zen=   
%     elseif beam ==5
% filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr5.csv'];
% azi=
% zen=    
%     elseif beam ==6
% filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr6.csv'];
% azi=
% zen=   
%     elseif beam ==7
% filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr7.csv'];
% azi=
% zen=    
%     elseif beam ==8
% filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr8.csv'];
%  azi=
% zen=   
%     end
% 
% %% read data from csv file by function
% cd(function_path)
% 
% VHF_data_pw1_n1data = importdata_pw1_n1_data(filename_pwr_n1,Data_path);
% cd(function_path)
% VHF_data_pw1_n1date  = datetime_datapw_n1(filename_pwr_n1,Data_path);
% 
% % VHF_data_pwr3_n1 = importdata(filename_pwr3_n1,Data_path);
% % VHF_data_pwr4_n1 = importdata(filename_pwr4_n1,Data_path);
% % VHF_data_pwr5_n1 = importdata(filename_pwr5_n1,Data_path);
% % VHF_data_pwr6_n1 = importdata(filename_pwr6_n1,Data_path);
% % VHF_data_pwr7_n1 = importdata(filename_pwr7_n1,Data_path);
% % VHF_data_pwr8_n1 = importdata(filename_pwr8_n1,Data_path);
% cd(main_path)
% % VHF_data_pw1_n1(:,1)=datestr(VHF_data_pw1_n1(3:end,1));
% % VHF_data_pw1_n1array = table2array(VHF_data_pw1_n1(:,2:end));
% 
% %% check -999 in data csv
% VHF_data_pw1_n1=nan(size(VHF_data_pw1_n1data));
% for i =1:length(VHF_data_pw1_n1data)
%     for j=1:length(VHF_data_pw1_n1data(1,:))
%         if VHF_data_pw1_n1data(i,j) == -999
%            VHF_data_pw1_n1(i,j)=nan; 
%         else
%             VHF_data_pw1_n1(i,j)=VHF_data_pw1_n1data(i,j);
%         end
%     end
% end
% timedata=table2array(VHF_data_pw1_n1date(:,2));
% time_data=datevec(timedata);
% secofday_data=nan(length(time_data),1);
% for j =1:length(time_data)
%       secofday_data(j,1)=time_data(j,4).*60.*60+time_data(j,5).*60+time_data(j,6);
% end
% 
% fig=figure(beam);
% time_use=linspace(time_start,time_stop,length(secofday_data(:)))';
% 
% contourf(1:length(secofday_data(:)),VHF_data_pw1_n1(2,:),VHF_data_pw1_n1(3:end,:)','edgecolor','none')
% xlim([0 571])
% caxis([-10 50])
% c = colorbar;
% ylabel('Altitude (Km)')
% xlabel('UT')
% c.Label.String = 'SNR (dB)';
% b=num2str(beam);
% title([filename_pwr_n1 'Beam=' b])
% disp(['status read from csv at n : 2==>' b])
% cd(file_plot)
% saveas(fig,[filename_pwr_n1 'Beam=' b '.jpg'])
% cd(data_mat)
% t=[filename_pwr_n1 'Beam=' b 'time.mat'];
% save(t,'timedata')
% d=[filename_pwr_n1 'Beam=' b 'data.mat'];
% save(d,'VHF_data_pw1_n1')
% cd(main_path)
% end
% 























