function [althi_1,althi_2] = read_data(Year,month,day)
%% find size of matrix 
cd(function_path)
filename                                           =   [Year month day '.faifb8p16n1.pwr1.csv'];
VHF_data_pw_n1data                      =   importdata_pw1_n1_data(filename,Data_path);

cd(function_path)
filename                                           =   [Year month day '.faifb8p16n2.pwr1.csv'];
VHF_data_pw_n2data                      =   importdata_pw1_n1_data(filename,Data_path);

[rownum1,colnum1]                        =   size(VHF_data_pw_n1data); %%for beam n =  1
[rownum2,colnum2]                        =   size(VHF_data_pw_n2data); %%for beam n =  2
althi_1                                               =   nan(rownum1*8,colnum1);
althi_2                                               =   nan(rownum2*8,colnum2);
j=0;
%% file name of csv file (from n=1)
for beam =1:8
    if beam ==1
            filename_pwr_n1           = [Year month day '.faifb8p16n1.pwr1.csv'];
            azi                                   = 125;
            zen                                  = 37.5;
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
althi_1(1+rownum1*j:rownum1*beam,:)      = importdata_pw1_n1_data(filename_pwr_n1,Data_path);
cd(function_path)
VHF_data_pw1_n1date  = datetime_datapw_n1(filename_pwr_n1,Data_path);



end

