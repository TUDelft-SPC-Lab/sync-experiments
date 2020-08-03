close all
clear all
clc

poissonSpacing=[1,4,2,2,3,3,2,2,5];

%% 20
[midgeAudio20,midgeAudioFs] = audioread('/Users/stephanietan/Desktop/syncExp/data/midge/20/158756522355.wav');

% cut off beginning and end of the recording
midgeAudio=midgeAudio20(1.2e6:2e6);

% threshold
midgeAudio = abs(midgeAudio);
midgeAudio(midgeAudio>0.1)=1;
midgeAudio(midgeAudio<0.1)=0;

figure
plot((1:length(midgeAudio))/midgeAudioFs,midgeAudio)

pos0 = find(midgeAudio==1);
pos1 = pos0(1:(end-1));
pos2 = pos0(2:end);
diffs = pos2-pos1;
cutoffDiff = 0.01*midgeAudioFs; % filter out noise of switches/spacings
diffs=diffs(diffs>cutoffDiff);
diffs = 1/midgeAudioFs*diffs;
offsetMidgeAudio20 = (poissonSpacing-diffs')*1000;

%% 37
[midgeAudio37,midgeAudioFs] = audioread('/Users/stephanietan/Desktop/syncExp/data/midge/37/1587565224556.wav');

% cut off beginning and end of the recording
midgeAudio=midgeAudio37(1.15e6:2e6);

% threshold
midgeAudio = abs(midgeAudio);
midgeAudio(midgeAudio>0.1)=1;
midgeAudio(midgeAudio<0.1)=0;

figure
plot((1:length(midgeAudio))/midgeAudioFs,midgeAudio)

pos0 = find(midgeAudio==1);
pos1 = pos0(1:(end-1));
pos2 = pos0(2:end);
diffs = pos2-pos1;
cutoffDiff = 0.01*midgeAudioFs; % filter out noise of switches/spacings
diffs=diffs(diffs>cutoffDiff);
diffs = 1/midgeAudioFs*diffs;
offsetMidgeAudio37 = (poissonSpacing-diffs')*1000;

%% 48
[midgeAudio48,midgeAudioFs] = audioread('/Users/stephanietan/Desktop/syncExp/data/midge/48/1587565226907.wav');

% cut off beginning and end of the recording
midgeAudio=midgeAudio48(1.1e6:2e6);

% threshold
midgeAudio = abs(midgeAudio);
midgeAudio(midgeAudio>0.1)=1;
midgeAudio(midgeAudio<0.1)=0;

figure
plot((1:length(midgeAudio))/midgeAudioFs,midgeAudio)

pos0 = find(midgeAudio==1);
pos1 = pos0(1:(end-1));
pos2 = pos0(2:end);
diffs = pos2-pos1;
cutoffDiff = 0.01*midgeAudioFs; % filter out noise of switches/spacings, keep big switches
diffs=diffs(diffs>cutoffDiff);
diffs = 1/midgeAudioFs*diffs;
offsetMidgeAudio48 = (poissonSpacing-diffs')*1000;

%% 18
[midgeAudio18,midgeAudioFs] = audioread('/Users/stephanietan/Desktop/syncExp/data/midge/18/1587565221504.wav');

% cut off beginning and end of the recording
midgeAudio=midgeAudio18(1.2e6:2e6);

% threshold
midgeAudio = abs(midgeAudio);
midgeAudio(midgeAudio>0.1)=1;
midgeAudio(midgeAudio<0.1)=0;

figure
plot((1:length(midgeAudio))/midgeAudioFs,midgeAudio)

pos0 = find(midgeAudio==1);
pos1 = pos0(1:(end-1));
pos2 = pos0(2:end);
diffs = pos2-pos1;
cutoffDiff = 0.3*midgeAudioFs; % filter out noise of switches/spacings, keep big switches
diffs=diffs(diffs>cutoffDiff);
diffs = 1/midgeAudioFs*diffs;
offsetMidgeAudio18 = (poissonSpacing-diffs')*1000;

averageOffsets = mean([offsetMidgeAudio20,offsetMidgeAudio37,offsetMidgeAudio48,offsetMidgeAudio18]);
stdOffsets = std([offsetMidgeAudio20,offsetMidgeAudio37,offsetMidgeAudio48,offsetMidgeAudio18]);
% [goProAudio,goProAudioFs] = audioread('goPro-output-audio.aac');
% 
% goProAudio = goProAudio(:,1); % take only one channel
% 
% % % downsample goPro Audio to midgeAudioFs-> first upsample, then downsample
% resampledGoProAudio = resample(goProAudio,10,1);
% resampledGoProAudio = resample(resampledGoProAudio,1,24);
% figure
% 
% t1=1/midgeAudioFs * (1:length(midgeAudio));
% plot(t1,midgeAudio);
% hold on
% t2=1/midgeAudioFs * (1:length(resampledGoProAudio));
% plot(t2,resampledGoProAudio)
% hold off
% set(gca,'box','off')
% xlim([5,45])
% ylabel('amplitude')
% xlabel('time(s)')
% legend('Midge Audio','GoPro Audio')
% 
% poissonSpacing=[1,4,2,2,3,3,2,2,5];
% 
% % threshold the signals
% resampledGoProAudio = resampledGoProAudio(5*midgeAudioFs:45*midgeAudioFs);
% resampledGoProAudio = abs(resampledGoProAudio);
% resampledGoProAudio(resampledGoProAudio>0.1)=1;
% resampledGoProAudio(resampledGoProAudio<0.1)=0;
% 
% 
% figure
% plot((1:length(resampledGoProAudio))/midgeAudioFs,resampledGoProAudio)
% 
% pos0 = find(resampledGoProAudio==1);
% pos1 = pos0(1:(end-1));
% pos2 = pos0(2:end);
% diffs = pos2-pos1;
% cutoffDiff = 0.3*midgeAudioFs;
% diffs=diffs(diffs>cutoffDiff);
% diffs = 1/midgeAudioFs*diffs;
% 
% offsetGoProAudio = max(poissonSpacing-diffs')*1000;


