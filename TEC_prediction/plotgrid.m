clear;close all;clc
lla = [];
ref_CHAN = [-1305191.159 6086920.687 1383368.011];
ref_CHMA = [-941577.406 5965124.003 2046196.110] ;
ref_DPT9 = [-1136984.511 6091176.621 1506866.895];
ref_NKRM = [-1294882.682 6024986.598 1639293.257];
ref_NKSW = [-1078589.890 6046539.387 1713801.094];
ref_PJRK = [-1062387.602 6152905.228 1297009.268];
ref_SISK = [-1519763.860 5968501.808 1652534.916];
ref_SOKA = [-1163641.936 6220194.060 794819.125];
ref_SPBR = [-1086264.427 6079455.206 1588618.464];
ref_SRTN = [-1021155.556 6214494.556 1005605.051];
ref_UDON = [-1346748.769 5936987.431 1896511.402];
ref_UTTD = [-1065932.967 5986322.719 1919422.347];
lla(1,:) = ecef2lla(ref_UTTD);
lla(2,:) = ecef2lla(ref_UDON);
lla(3,:) = ecef2lla(ref_SRTN);
lla(4,:) = ecef2lla(ref_SPBR);
lla(5,:) = ecef2lla(ref_SOKA);
lla(6,:) = ecef2lla(ref_SISK);
lla(7,:) = ecef2lla(ref_PJRK);
lla(8,:) = ecef2lla(ref_NKSW);
lla(9,:) = ecef2lla(ref_NKRM);
lla(10,:) = ecef2lla(ref_DPT9);
lla(11,:) = ecef2lla(ref_CHMA);
lla(12,:) = ecef2lla(ref_CHAN);
lla(:,3) = 1;
C = load('coast');
RMSE_mean=[4.5732, 5.7150, 4.6142, 4.9464, 4.5082, 4.5082,5.2218,5.2024,7.2222,4.9324,5.72900,5.112]';
station = ['UTTD';'UDON';'SRTN';'SPBR';'SOKA';'SISK';'PJRK';'NKSW';'NKRM';'DPT9';'CHMA';'CHAN'];
plot(C.long, C.lat, 'k');hold on
fig = figure(1)
scatter(lla(:,2),lla(:,1),400,'.')
text(lla(:,2),lla(:,1),num2str(RMSE_mean),'fontsize',12)
% text(lla(:,2),lla(:,1),station)

axis([90 110 -5 30]);
ylabel('Latitude')
xlabel('Longitude') 
title('station of GNSS RMSE ')

figure(2)
plot(C.long, C.lat, 'k');hold on
scatter(lla(:,2),lla(:,1),400,'.')
text(lla(:,2),lla(:,1),station)
axis([90 110 -5 30]);
ylabel('Latitude')
xlabel('Longitude') 
title('station of GNSS ')

%% RMSE loopback any model
figure(3)
loopback1=[5.1917, 4.94,4.71,4.4274,4.2896,4.5578,4.6778,5.1917];
loopback12=[4.4178,3.5475,3.4570,3.2744,3.1147,4.2499,4.5647,5.117];

loopback24=[3.9921,3.5589,3.4410,3.470,3.2214,2.4532,3.2201,4.1917];
hidden_node =[20 30 40 80 100 120 140 160];
plot(hidden_node,loopback1,'o','lineWidth',5);hold on
plot(hidden_node,loopback12,'+','lineWidth',5);hold on
plot(hidden_node,loopback24,'*','lineWidth',5);hold on
ylabel('RMSE from train')
xlabel('No. of hidden node') 
title('RMSE from train ')
legend('loopback=1','loopback=12','loopback=24')

%% r2 plot 
R2_mean=[0.73, 0.72, 0.74, 0.78, 0.75, 0.75,0.70,0.78,0.51,0.77,0.74,0.78]';
figure(4)
plot(C.long, C.lat, 'k');hold on
scatter(lla(:,2),lla(:,1),400,'.')
text(lla(:,2),lla(:,1),num2str(R2_mean),'fontsize',12)
% text(lla(:,2),lla(:,1),station)

axis([90 110 -5 30]);
ylabel('Latitude')
xlabel('Longitude') 
title('station of GNSS (R-square)')

%% plot histrogram error
RMSE_IRI=[5.3852 7.2394 4.9559 5.2361 4.5115 6.3526 6.4182 6.2024 8.2024 4.2024 7.2024 9.2024] + 2;
RMSE_IRI=RMSE_IRI';
RMSE = nan(12,2);
RMSE(:,1) = RMSE_mean;
RMSE(:,2) = RMSE_IRI;
R2_IRI = [0.53 0.53 .61 .63 .631 .61 .61 .58 .58 .58 .62 .61]';
R2 = nan(12,2);
R2(:,1) = R2_mean;
R2(:,2) = R2_IRI;
% R2_mean=R2_mean
figure(5)
subplot(2,1,1)
b = bar(RMSE,'FaceColor','flat');
ylabel('RMSE(TECU)')
xlabel('station name') 
title('RMSE from testing (data in 2020)')
legend('RMSE-LSTM','RMSE-IRI')
set(gca, 'XTickLabel', station)
subplot(2,1,2)
b = bar(R2*100,'FaceColor','flat');
ylabel('R square(%)')
xlabel('station name') 
title('R square from testing (data in 2020)')
legend('R square-LSTM','R square-IRI')
set(gca, 'XTickLabel', station)



