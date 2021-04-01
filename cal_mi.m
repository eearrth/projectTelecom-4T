%%%%%%%%%%%%% calculate Mutual Information (MI) of solarpastpastpastpast Activity and TEC %%%%%%%%%%%%%%%%%%%
% To select the input i choose to fix Hr,mth,doy,year,lat,long and solarpastpastpastpast parameter
% that low MI 
clc;clear all; close all;
 m_path=[pwd '\']; % main path
 f_path=[m_path 'function\']; %function path
 d_path=[m_path 'Data_solar\']; %data path
dt_path=[m_path 'data_TEC_scale\']; % data TEC path
month=nan(78912,1);
 filename=[d_path '\solarpast.mat'];
x=0;
 z=1;
 
%  for ii=0:3287
%     for i=1:24
%        
%          d = datetime(['01-Jan-2008'])+ii;
% %  d = datetime('10-Jul-2020');x
% % d = datetime('07-Jun-2020'); % d = '25-Mar-2019' '4-Mar-2020' '13-Feb-2020'; change d only !
% date = datevec(d);
% D1 = date(:,1:3);
% D2 = D1;
% D2(:,2:3) = 0;
% ydoy = cat(2, D1(:,1), datenum(D1) - datenum(D2));
% Year = num2str(ydoy(1,1));
% w=D1(1)-2000;
% Year2 = num2str(w,'%.2d');
% mth = D1(2);
% doy = num2str(ydoy(1,2),'%.3d');
% month(x*24+1:24*(z))=mth;
% 
%     
%     end
%  x=x+1;
% z=z+1;
%  end 

 load(filename)

 file_TEC_name=[m_path '\data_TEC_scale\TEC_SRTN_scale.mat'];
load(file_TEC_name)
%% 
cd(f_path)
TEC = rescale(TEC);
solarpast(:,4) = rescale(solarpast(:,4));
solarpast(:,5) = rescale(solarpast(:,5));
solarpast(:,6) = rescale(solarpast(:,6));
solarpast(:,7) = rescale(solarpast(:,7));
solarpast(:,8) = rescale(solarpast(:,8));
solarpast(:,9) = rescale(solarpast(:,9));
solarpast(:,10) = rescale(solarpast(:,10));
solarpast(:,11) = rescale(solarpast(:,11));
solarpast(:,12) = rescale(solarpast(:,12));
solarpast(:,13) = rescale(solarpast(:,13));
solarpast(:,14) = rescale(solarpast(:,14));
solarpast(:,15) = rescale(solarpast(:,15));
solarpast(:,16) = rescale(solarpast(:,16));
solarpast(:,17) = rescale(solarpast(:,17));

I_SB=mi(TEC,solarpast(:,4));
I_Bx=mi(TEC,solarpast(:,5));
I_By=mi(TEC,solarpast(:,6));
I_Bz=mi(TEC,solarpast(:,7));
I_Bym=mi(TEC,solarpast(:,8));
I_Bzm=mi(TEC,solarpast(:,9));
I_sw=mi(TEC,solarpast(:,10));
I_long=mi(TEC,solarpast(:,11));
I_lat=mi(TEC,solarpast(:,12));
I_kp=mi(TEC,solarpast(:,13));
I_Rz=mi(TEC,solarpast(:,14));
I_dst=mi(TEC,solarpast(:,15));
I_f10=mi(TEC,solarpast(:,16));
I_pf=mi(TEC,solarpast(:,17));

cd(m_path)
%% correlation

C_SB=corr(TEC',solarpast(:,4));
C_Bx=corr(TEC',solarpast(:,5));
C_By=corr(TEC',solarpast(:,6));
C_Bz=corr(TEC',solarpast(:,7));
C_Bym=corr(TEC',solarpast(:,8));
C_Bzm=corr(TEC',solarpast(:,9));
C_sw=corr(TEC',solarpast(:,10));
C_long=corr(TEC',solarpast(:,11));
C_lat=corr(TEC',solarpast(:,12));
C_kp=corr(TEC',solarpast(:,13));
C_Rz=corr(TEC',solarpast(:,14));
C_dst=corr(TEC',solarpast(:,15));
C_f10=corr(TEC',solarpast(:,16));
C_pf=corr(TEC',solarpast(:,17));

 
 