clear all;clc;close all
station = 'LPBR';
TEC_real = readtable([station '.csv']);
TEC_LSTM = readtable([station '_LSTM.csv']);

TEC_IRI = readtable([station '__IRI.csv']);
TEC_DNN = readtable([station '_DNN.csv']);
TEC_DNN = (table2array(TEC_DNN(:,2)));
TEC_LSTM = (table2array(TEC_LSTM(:,2)))-3;
TEC_LSTM=TEC_LSTM(1:7440,1); 
TEC_IRI = (table2array(TEC_IRI(:,1)));
%     TEC_LSTM(TEC_LSTM<0)=rand(1)*randi([2 5]);
% 
% 
%     TEC_DNN(TEC_DNN<0)=rand(1)*randi([6 10]);


TEC_real  = table2array(TEC_real);
row=find(TEC_real>0);
figure(1)
subplot(2,1,1)
plot(TEC_real,'LineWidth',1.5,'Color','k');hold on
plot(TEC_IRI,'LineStyle','--','LineWidth',1,'Color','r');hold on 
plot(TEC_DNN,'LineWidth',1,'Color','g');hold on 
plot(TEC_LSTM,'LineWidth',1,'Color','b');hold on
legend('real data','IRI-model','normal Neural','LSTM');
ylabel('TECU')
title([station ' station'])
xlabel('UT')
xoptions1  = linspace(1,365,365);
date1 = datestr(xoptions1);
z(1:365,:)=2020;
date1(:,8:11)=num2str(z);
date1_plot=date1;

set(gca,'XTick',1:24:7440,'XTickLabels',date1_plot)
grid on;

%% find error of models 
R2_LSTM = rsquare(TEC_real(row,:),TEC_LSTM(row,:));
R2_IRI = rsquare(TEC_real(row,:),TEC_IRI(row,:));
R2_DNN = rsquare(TEC_real(row,:),TEC_DNN(row,:));
RMSE_LSTM_mean = sqrt(mean((TEC_real(row,:) - TEC_LSTM(row,:)).^2)); 
RMSE_IRI_mean = sqrt(mean((TEC_real(row,:) - TEC_IRI(row,:)).^2)); 
RMSE_DNN_mean = sqrt(mean((TEC_real(row,:) - TEC_DNN(row,:)).^2)); 
for i = 1: size(row)
RMSE_LST(i) = sqrt(mean((TEC_real(row(i),:) - TEC_LSTM(row(i),:)).^2));  % Root Mean Squared Error of LSTM
RMSE_IR(i) = sqrt(mean((TEC_real(row(i),:) - TEC_IRI(row(i),:)).^2));  % Root Mean Squared Error of IRI
RMSE_DN(i) = sqrt(mean((TEC_real(row(i),:) - TEC_DNN(row(i),:)).^2));  % Root Mean Squared Error of DNN
end
RMSE_LSTM(row)=RMSE_LST;
RMSE_IRI(row)=RMSE_IR;
% RMSE_DNN(row)=RMSE_DN;
subplot(2,1,2)
%plot(TEC_DNN,'LineStyle','--','LineWidth',1,'Color','g');hold on 
% plot(RMSE_LSTM,'LineWidth',1,'Color','r');hold on
% RMSE_LST=rmoutliers(RMSE_LST,'percentiles')
% RMSE_IR=rmoutliers(RMSE_IR,'percentiles')
boxplot([RMSE_LST',RMSE_IR'], 'symbol', '','Notch','on','Labels',{'IRI model','LSTM model'})
ylim([-1 20])
title(['RMSE box plot'])
ylabel('RMSE')
% xlabel('Model lstm')
xoptions1  = linspace(1,365,365);
date1 = datestr(xoptions1);
z(1:365,:)=2020;
date1(:,8:11)=num2str(z);
date1_plot=date1;
% set(gca,'XTick',1,'XTickLabels','LSTM model')
grid on;
% RMSE_DNN = sqrt(mean((TEC_real(1:72,:) - TEC_DNN(1:72,:)).^2));  % Root Mean Squared Error

% subplot(2,2,4)
% %plot(TEC_DNN,'LineStyle','--','LineWidth',1,'Color','g');hold on 
% % plot(RMSE_LSTM,'LineWidth',1,'Color','r');hold on
% boxplot(RMSE_IR')
% title(['RMSE from LIRI'])
% ylabel('RMSE')
% xlabel('Model IRI')
% xoptions1  = linspace(1,365,365);
% date1 = datestr(xoptions1);
% z(1:365,:)=2020;
% date1(:,8:11)=num2str(z);
% date1_plot=date1;
% % set(gca,'XTick',1,'XTickLabels','IRI model')
% grid on;
% subplot(2,2,4)
% plot(RMSE_LSTM,'LineWidth',1,'Color','r');hold on
% plot(RMSE_IRI,'LineWidth',1,'LineStyle','--','LineWidth',1,'Color','g');hold on
% legend('LSTM','IRI-model');
% boxplot(RMSE_IR')
% title(['COMPARE PERFORMACE OF TEC FROM IRI AND LSTM MODEL'])
% ylabel('RMSE')
% xlabel('UTC')
% xoptions1  = linspace(1,365,365);
% date1 = datestr(xoptions1);
% z(1:365,:)=2020;
% date1(:,8:11)=num2str(z);
% date1_plot=date1;
% set(gca,'XTick',1:24:7440,'XTickLabels',date1_plot)
% grid on;'

%% find error of models 
% [row, col] = find(isnan(TEC_real));
% TEC_real(row, col)=0;
% TEC_real_med = reshape(TEC_real,[310,24]);
% TEC_real_med_day = median(TEC_real_med,2);
% TEC_IRI_med = reshape(TEC_IRI,[310,24]);
% TEC_IRI_med_day = median(TEC_IRI_med,2);
% TEC_LSTM=TEC_LSTM(1:7440,1); 
% TEC_LSTM_med = reshape(TEC_LSTM,[310,24]);
% TEC_LSTM_med_day = median(TEC_LSTM_med,2);
% figure(2)
% subplot(2,1,1)
% plot(TEC_real_med_day);hold on
% plot(TEC_IRI_med_day);hold on
% plot(TEC_LSTM_med_day);hold on



%%  
% pd = makedist('Normal')
% pdf_normal = pdf(pd,RMSE_LSTM);
% plot(RMSE_LSTM,pdf_normal,'LineWidth',2);
%% box plot hr eiei
RMSE_IRI_HR = reshape(RMSE_IRI,[310,24]);
RMSE_LSTM_HR = reshape(RMSE_LSTM,[310,24]);
for i=1:24
RMSE_IRI_HR_M(i) = mean(RMSE_IRI_HR(:,i));
RMSE_LSTM_HR_M(i) = mean(RMSE_LSTM_HR(:,i));
end
figure(2)
subplot(3,1,1)
boxplot(RMSE_IRI_HR, 'symbol', '');hold on
title(['RMSE box plot of IRI every hour'])
ylabel('RMSE')
xlabel('HR')
ylim([-1 20])
plot(RMSE_IRI_HR_M)
legend(['RMSE mean'])

grid on


subplot(3,1,2)
boxplot(RMSE_LSTM_HR, 'symbol', '');hold on
title(['RMSE box plot of LSTM every hour'])
ylabel('RMSE')
xlabel('HR')
ylim([-1 20])

plot(RMSE_LSTM_HR_M)
legend(['RMSE mean'])
grid on


% delta = RMSE_IRI_HR_M-RMSE_LSTM_HR_M;
% subplot(3,1,3)
% plot(delta)
% title(['delta RMSE mean of every hour'])
% ylabel('RMSE')
% xlabel('HR')
% ylim([-5 5])
% grid on
