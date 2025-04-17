%BEAP PART 2

load('C:\Users\user\Documents\Datafiles+for+project+2-20201105\noisy_both');
load('C:\Users\user\Documents\Datafiles+for+project+2-20201105\noisy_left');
load('C:\Users\user\Documents\Datafiles+for+project+2-20201105\noisy_right');

%1- BEAP OF BOTH EARS
x = (0:0.05:12.5);
S_BOTHAVG = mean(S_BOTH);
S_BOTHSTD = std(S_BOTH);
CI_BOTH1 = S_BOTHAVG - (2*S_BOTHSTD/sqrt(2000));
CI_BOTH2 = S_BOTHAVG + (2*S_BOTHSTD/sqrt(2000));

%2- BEAP OF LEFT EAR
S_LEFTAVG = mean(S_LEFT);
S_LEFTSTD = std(S_LEFT);
CI_LEFT1 = S_LEFTAVG - (2*S_LEFTSTD/sqrt(2000));
CI_LEFT2 = S_LEFTAVG + (2*S_LEFTSTD/sqrt(2000));


%3- BEAP OF RIGHT EAR
S_RIGHTAVG = mean(S_RIGHT);
S_RIGHTSTD = std(S_RIGHT);
CI_RIGHT1 = S_RIGHTAVG - (2*S_RIGHTSTD/sqrt(2000));
CI_RIGHT2 = S_RIGHTAVG + (2*S_RIGHTSTD/sqrt(2000));

figure(1);
subplot(2,1,1)
plot(x,S_BOTHAVG); 
hold on
plot(x,CI_BOTH1,'red');
hold on
plot(x,CI_BOTH2,'red');
title('BEAP_B Mean');
xlabel('Time (ms)');
subplot(2,1,2)
plot(x,S_BOTH(14,:));
title('BEAP_B TRIAL 14');
xlabel('Time (ms)');

figure(2);
subplot(2,1,1)
plot(x,S_LEFTAVG);
hold on
plot(x,CI_LEFT1,'red');
hold on
plot(x,CI_LEFT2,'red');
title('BEAP_L Mean');
xlabel('Time (ms)');
subplot(2,1,2)
plot(x,S_LEFT(14,:));
title('BEAP_L TRIAL 14');
xlabel('Time (ms)');

figure(3);
subplot(2,1,1)
plot(x,S_RIGHTAVG,'blue');
hold on
plot(x,CI_RIGHT1,'red');
hold on
plot(x,CI_RIGHT2,'red');
title('BEAP_R Mean');
xlabel('Time (ms)');
subplot(2,1,2)
plot(x,S_RIGHT(14,:));
title('BEAP_R TRIAL 14');
xlabel('Time (ms)');

%% PART 3 : SNR

%SNR for trial 255
noise1_255 = var(S_BOTH(255,:)) - var(S_BOTHAVG);
SNR_BOTH_255 = var(S_BOTHAVG)/noise1_255;
noise2_255 = var(S_LEFT(255,:)) - var(S_LEFTAVG);
SNR_LEFT_255 = var(S_LEFTAVG)/noise2_255;
noise3_255 = var(S_RIGHT(255,:)) - var(S_RIGHTAVG);
SNR_RIGHT_255 = var(S_RIGHTAVG)/noise3_255;
%% 
noise1 = zeros(1,2000); % Memory preallocation
for i = 1:1:2000
noise1(i) = var(S_BOTH(i,:)) - var(S_BOTHAVG);
end
noiseavg = mean(noise1);
noisestd = std(noise1);
SNR_BOTH = var(S_BOTHAVG)/noiseavg;

noise2 = zeros(1,2000); % Memory preallocation
for i = 1:1:2000
noise2(i) = var(S_LEFT(i,:)) - var(S_LEFTAVG);
end
noiseavg1 = mean(noise2);
noisestd1 = std(noise2);
SNR_LEFT = var(S_LEFTAVG)/noiseavg1;

noise3 = zeros(1,2000); % Memory preallocation
for i = 1:1:2000
noise3(i) = var(S_RIGHT(i,:)) - var(S_RIGHTAVG);
end
noiseavg2 = mean(noise3);
noisestd2 = std(noise3);
SNR_RIGHT = var(S_RIGHTAVG)/noiseavg2;

%Standard error

se_both = noisestd/sqrt(2000);
se_left = noisestd1/sqrt(2000);
se_right = noisestd2/sqrt(2000);

%% compute and  plot the epoch by epoch value of the autocovariance function
%of the raw data

autocov_left = zeros(2000,501);
autocov_right = zeros(2000,501);
autocov_both = zeros(2000,501);
for i = 1:1:2000
autocov_left(i,:) = xcov(S_LEFT(i,:));
autocov_right(i,:) = xcov(S_RIGHT(i,:));
autocov_both(i,:) = xcov(S_BOTH(i,:));
end
x = linspace(-250,250,501);
autocov_leftavg = mean(autocov_left);
autocov_rightavg = mean(autocov_right);
autocov_bothavg = mean(autocov_both);
figure()
subplot(3,1,1)
plot(x,autocov_leftavg);
title('Autocovariance of Left ear');
subplot(3,1,2)
plot(x,autocov_rightavg);
title('Autocovariance of Right ear');
subplot(3,1,3)
plot(x,autocov_bothavg);
title('Autocovariance of Both ears');

%% BID

BID = zeros(2000,251);
meanall = mean([S_LEFTAVG  S_RIGHTAVG  S_BOTHAVG]);
for i = 1:1:2000
    BID(i,:) = (S_LEFT(i,:) + S_RIGHT(i,:)) - S_BOTH(i,:) - meanall;
end

BID_avg = mean(BID);
BID_std = std(BID);
CI_BID1 = BID_avg - (2*BID_std/sqrt(2000));
CI_BID2 = BID_avg + (2*BID_std/sqrt(2000));

figure()
plot(BID_avg);
hold on
plot(CI_BID1,'red');
hold on
plot(CI_BID2,'red');
title('Average BID');

%%  5

load('C:\Users\user\Documents\Datafiles+for+project+2-20201105\ITD02'); 

%BID for interaural time difference of 0.2 msec
%beta waves are between 12.5 and 30 Hz
%filter FIR bandpass

b = fir1(48,[0.25 0.60]); %bandpass filter of order 48

freqz(b,1,512);
out = filter(b,1,s_r);
out1 = filter(b,1,s_l);
out2 = filter(b,1,s_both);

figure()
subplot(3,1,1)
plot(out);
title('Beta Potential for Right ear at 0.2 msec')
subplot(3,1,2)
plot(out1);
title('Beta Potential for Left ear at 0.2 msec')
subplot(3,1,3)
plot(out2);
title('Beta Potential for Both ears at 0.2 msec')

% creating template of beta wave for ITD02

for i = 1:1:49
    temp(1,i) = out(1,i); 
end

% Create a matched filter based on the template
b = fliplr(temp); %flipped template

figure()
plot(b);
title('Template for matched filter')

%%
load('C:\Users\user\Documents\Datafiles+for+project+2-20201105\ITD04'); 

c_r = conv(b,s_r);
c_l = conv(b,s_l);
c_b = conv(b,s_both);

figure()
subplot(3,1,1)
plot(c_r);
title('Beta Potential of Right ear at 0.4 msec')
subplot(3,1,2)
plot(c_l);
title('Beta Potential of Left ear at 0.4 msec')
subplot(3,1,3)
plot(c_b);
title('Beta Potential of Both ears at 0.4 msec')

%%
load('C:\Users\user\Documents\Datafiles+for+project+2-20201105\ITD12'); 

c_r1 = conv(b,s_r);
c_l1 = conv(b,s_l);
c_b1 = conv(b,s_both);

figure()
subplot(3,1,1)
plot(c_r1);
title('Beta Potential of Right ear at 1.2 msec')
subplot(3,1,2)
plot(c_l1);
title('Beta Potential of Left ear at 1.2 msec')
subplot(3,1,3)
plot(c_b1);
title('Beta Potential of Both ears at 1.2 msec')

%%
load('C:\Users\user\Documents\Datafiles+for+project+2-20201105\ITD16'); 

c_r2 = conv(b,s_r);
c_l2 = conv(b,s_l);
c_b2 = conv(b,s_both);

figure()
subplot(3,1,1)
plot(c_r2);
title('Beta Potential of Right ear at 1.6 msec')
subplot(3,1,2)
plot(c_l2);
title('Beta Potential of Left ear at 1.6 msec')
subplot(3,1,3)
plot(c_b2);
title('Beta Potential of Both ears at 1.6 msec')
