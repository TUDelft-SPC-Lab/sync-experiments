close all
clear all
clc

[midgeAudio,midgeAudioFs] = audioread('output2_Midge2.wav');
[goProAudio,goProAudioFs] = audioread('goPro-output-audio.aac');

goProAudio = goProAudio(:,1); % take only one channel

% % downsample goPro Audio to midgeAudioFs-> first upsample, then downsample
resampledGoProAudio = resample(goProAudio,10,1);
resampledGoProAudio = resample(resampledGoProAudio,1,24);
figure

t1=1/midgeAudioFs * (1:length(midgeAudio));
plot(t1,midgeAudio);
hold on
t2=1/midgeAudioFs * (1:length(resampledGoProAudio));
plot(t2,resampledGoProAudio)
hold off
set(gca,'box','off')
xlim([5,45])
ylabel('amplitude')
xlabel('time(s)')
legend('Midge Audio','GoPro Audio')

poissonSpacing=[1,4,2,2,3,3,2,2,5];

% threshold the signals
resampledGoProAudio = resampledGoProAudio(5*midgeAudioFs:45*midgeAudioFs);
resampledGoProAudio = abs(resampledGoProAudio);
resampledGoProAudio(resampledGoProAudio>0.1)=1;
resampledGoProAudio(resampledGoProAudio<0.1)=0;


figure
plot((1:length(resampledGoProAudio))/midgeAudioFs,resampledGoProAudio)

pos0 = find(resampledGoProAudio==1);
pos1 = pos0(1:(end-1));
pos2 = pos0(2:end);
diffs = pos2-pos1;
cutoffDiff = 0.3*midgeAudioFs;
diffs=diffs(diffs>cutoffDiff);
diffs = 1/midgeAudioFs*diffs;

offsetGoProAudio = max(poissonSpacing-diffs')*1000;

% % threshold the signals
midgeAudio = midgeAudio(5*midgeAudioFs:45*midgeAudioFs);
midgeAudio = abs(midgeAudio);
midgeAudio(midgeAudio>0.1)=1;
midgeAudio(midgeAudio<0.1)=0;

figure
plot((1:length(midgeAudio))/midgeAudioFs,midgeAudio)

pos0 = find(midgeAudio==1);
pos1 = pos0(1:(end-1));
pos2 = pos0(2:end);
diffs = pos2-pos1;
cutoffDiff = 0.2*midgeAudioFs;
diffs=diffs(diffs>cutoffDiff);
diffs = 1/midgeAudioFs*diffs;
offsetMidgeAudio = max(poissonSpacing-diffs')*1000;

% x0 = resampledGoProAudio(50000:850000);
% y0 = midgeAudio(50000:850000);
% t0 = 1:length(x0);
% x0= midgeAudio(100000:900000);
% y0 =goProAudio(200000:2000000);
% % t0 = 1:length(x0);
% 
% % downsample further
% % factor = 1000;
% x_factor = 5;
% y_factor = 10; 
% x = decimate(x0,x_factor);
% y = decimate(y0,y_factor);
% % t = decimate(t0,factor);
% 
% % figure
% % plot(t0,x0)
% figure
% plot(x0)
% figure
% plot(y0)
% % hold on
% % plot(t0,y0)
% 
% figure
% plot(x)
% % hold on
% figure
% plot(y)
% 
% 
% % return
% % len = length(x);
% % idx=(1:100000:len)+30000;
% % x=0*x;
% % x(idx)=1;
% % x=sin(2*pi*(1/60000)*(1:length(x)));
% % y=0*y;
% % sampleDelay = 35000;
% % y(idx+sampleDelay)=1;
% % plot(x)
% % hold on
% % plot(y)
% % timeDelay = sampleDelay/midgeAudioFs
% 
% 
% % % computer signal similarities
% [c,lags] = xcorr(y,x);
% % % normalize
% c_new = c./max(abs(c(:)));
% 
% figure
% plot(lags/(min(midgeAudioFs/x_factor,goProAudioFs/y_factor)),c_new,'k');
% [~,I]=max(abs(c));
% timeDiff = lags(I)/min(midgeAudioFs/x_factor,goProAudioFs/y_factor);
% figure
% stem(lags,c)
% 
