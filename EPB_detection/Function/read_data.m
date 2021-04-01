function [althi_1,althi_2,rownum1,colnum1  ,rownum2,colnum2,...
    alt1_data,alt2_data,alt1_hight,alt2_hight,alt1_range,alt2_range,...
    row_alt1d,col_alt1d,row_alt2d,col_alt2d,VHF_data_pw1_n1date,VHF_data_pw1_n2date]...
    = read_data(Year,month,day,Data_path,function_path)
%% find size of matrix 

filename                                           =   [Year month day '.faifb8p16n1.pwr1.csv'];
VHF_data_pw_n1data                      =   importdata_pw1_n1_data(filename,Data_path);

cd(function_path)
filename                                           =   [Year month day '.faifb8p16n2.pwr1.csv'];
VHF_data_pw_n2data                      =   importdata_pw1_n1_data(filename,Data_path);
cd(function_path) 
[rownum1,colnum1]                        =   size(VHF_data_pw_n1data); %%for beam n =  1
[rownum2,colnum2]                        =   size(VHF_data_pw_n2data); %%for beam n =  2
% althi_1                                               =   nan(rownum1*8,colnum1);
% althi_2                                               =   nan(rownum2*8,colnum2);
alt1_data                                           =   nan(rownum1*8-2,colnum1);
row_alt1d                                          =  rownum1-2;
col_alt1d                                           =   colnum1 ;
alt2_data                                           =  nan(rownum2*8-2,colnum2);
row_alt2d                                          =  rownum2-2;
col_alt2d                                           =  colnum2 ;
alt1_hight                                         =   nan(8,colnum1);
alt2_hight                                         =   nan(8,colnum2);
alt1_range                                        =   nan(8,colnum1);
alt2_range                                        =   nan(8,colnum2);
j=0;
%% file name of csv file (from n=1)
for beam =1:8
    if beam ==1
            filename_pwr_n1            = [Year month day '.faifb8p16n1.pwr1.csv'];
            azi                                   = 125;
            zen                                  = 37.5;
                            disp(filename_pwr_n1)
    elseif beam==2
            filename_pwr_n1            = [Year month day '.faifb8p16n1.pwr2.csv'];
            azi                                    =137;
            zen                                   =30.9;
            disp(filename_pwr_n1)
    elseif beam==3
            filename_pwr_n1 = [Year month day '.faifb8p16n1.pwr3.csv'];
            azi=151;
            zen=26.6;
            disp(filename_pwr_n1)
    elseif beam ==4
            filename_pwr_n1 = [Year month day '.faifb8p16n1.pwr4.csv'];
            azi=165;
            zen=24.5;
                disp(filename_pwr_n1)
    elseif beam ==5
            filename_pwr_n1 = [Year month day '.faifb8p16n1.pwr5.csv'];
            azi=180;
            zen=23.8;
    elseif beam ==6
            filename_pwr_n1 = [Year month day '.faifb8p16n1.pwr6.csv'];
            azi=195;
            zen=24.7;
                disp(filename_pwr_n1)
    elseif beam ==7
            filename_pwr_n1 = [Year month day '.faifb8p16n1.pwr7.csv'];
            azi=209;
            zen=27.2;
                disp(filename_pwr_n1)
    elseif beam ==8
            filename_pwr_n1 = [Year month day '.faifb8p16n1.pwr8.csv'];
            azi=223;
            zen=32.1;
                disp(filename_pwr_n1)
    end
  
althi_1 = importdata_pw1_n1_data(filename_pwr_n1,Data_path);
cd(function_path)
alt1_data(1+row_alt1d*j:row_alt1d*beam,:)  =  importdata(filename_pwr_n1,Data_path);
alt1_range(beam,:)                                                       =   althi_1(1,:);
alt1_hight(beam,:)                                                        =   althi_1(2,:);
cd(function_path)
VHF_data_pw1_n1date  = datetime_datapw_n1(filename_pwr_n1,Data_path);
cd(function_path)
j=j+1;
    disp([filename_pwr_n1 '====>read done'])
end
%% file name of csv file (from n=2)
j=0;
for beam =1:8
    if beam ==1
                filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr1.csv'];
                disp(filename_pwr_n1)
    elseif beam==2
                filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr2.csv'];
                disp(filename_pwr_n1)                
    elseif beam==3
                filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr3.csv'];
                disp(filename_pwr_n1) 
    elseif beam ==4
                filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr4.csv'];
                disp(filename_pwr_n1)
    elseif beam ==5
                filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr5.csv'];
                disp(filename_pwr_n1) 
    elseif beam ==6
                filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr6.csv'];
                disp(filename_pwr_n1)
    elseif beam ==7
                filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr7.csv'];
                disp(filename_pwr_n1)
    elseif beam ==8
                filename_pwr_n1 = [Year month day '.faifb8p16n2.pwr8.csv'];
                disp(filename_pwr_n1)                
    end
    althi_2        = importdata_pw1_n1_data(filename_pwr_n1,Data_path);
    cd(function_path)
    alt2_data(1+row_alt2d*j:row_alt2d*beam,:)  =  importdata(filename_pwr_n1,Data_path);
    alt2_range(beam,:)                                                       =   althi_2(1,:);
    alt2_hight(beam,:)                                                        =   althi_2(2,:);
cd(function_path)
    cd(function_path)
    VHF_data_pw1_n2date  = datetime_datapw_n1(filename_pwr_n1,Data_path);
    cd(function_path)
    j=j+1;
    disp([filename_pwr_n1 '====>read done'])
    end
