close all
clear all
clc

poissonSpacing=[1,4,2,2,3,3,2,2,5];

%% 2
[goProAudio,goProAudioFs] = audioread('/Users/stephanietan/Desktop/syncExp/data/gopro/cam2/goPro-output-audio2.aac');
[midgeAudio20,midgeAudioFs] = audioread('/Users/stephanietan/Desktop/syncExp/data/midge/20/158756522355.wav');

goProAudio = goProAudio(:,1); % take only one channel

% % downsample goPro Audio to midgeAudioFs-> first upsample, then downsample
resampledGoProAudio = resample(goProAudio,10,1);
resampledGoProAudio = resample(resampledGoProAudio,1,24);

% threshold the signals
resampledGoProAudio = resampledGoProAudio(3.7e5:11e5);
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

offsetGoProAudio2 = (poissonSpacing-diffs')*1000;

%% 8
[goProAudio,goProAudioFs] = audioread('/Users/stephanietan/Desktop/syncExp/data/gopro/cam8/goPro-output-audio8.aac');
[midgeAudio20,midgeAudioFs] = audioread('/Users/stephanietan/Desktop/syncExp/data/midge/20/158756522355.wav');

goProAudio = goProAudio(:,1); % take only one channel

% % downsample goPro Audio to midgeAudioFs-> first upsample, then downsample
resampledGoProAudio = resample(goProAudio,10,1);
resampledGoProAudio = resample(resampledGoProAudio,1,24);

% threshold the signals
resampledGoProAudio = resampledGoProAudio(3.7e5:11e5);
resampledGoProAudio = abs(resampledGoProAudio);
resampledGoProAudio(resampledGoProAudio>0.1)=1;
resampledGoProAudio(resampledGoProAudio<0.1)=0;

figure
plot((1:length(resampledGoProAudio))/midgeAudioFs,resampledGoProAudio)

pos0 = find(resampledGoProAudio==1);
pos1 = pos0(1:(end-1));
pos2 = pos0(2:end);
diffs = pos2-pos1;
cutoffDiff = 0.1*midgeAudioFs;
diffs=diffs(diffs>cutoffDiff);
diffs = 1/midgeAudioFs*diffs;

offsetGoProAudio8 = (poissonSpacing-diffs')*1000;

%% 12
[goProAudio,goProAudioFs] = audioread('/Users/stephanietan/Desktop/syncExp/data/gopro/cam12/goPro-output-audio12.aac');
[midgeAudio20,midgeAudioFs] = audioread('/Users/stephanietan/Desktop/syncExp/data/midge/20/158756522355.wav');

goProAudio = goProAudio(:,1); % take only one channel

% % downsample goPro Audio to midgeAudioFs-> first upsample, then downsample
resampledGoProAudio = resample(goProAudio,10,1);
resampledGoProAudio = resample(resampledGoProAudio,1,24);

% threshold the signals
resampledGoProAudio = resampledGoProAudio(3.7e5:11e5);
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

offsetGoProAudio12 = (poissonSpacing-diffs')*1000;

%% 13
[goProAudio,goProAudioFs] = audioread('/Users/stephanietan/Desktop/syncExp/data/gopro/cam13/goPro-output-audio13.aac');
[midgeAudio20,midgeAudioFs] = audioread('/Users/stephanietan/Desktop/syncExp/data/midge/20/158756522355.wav');

goProAudio = goProAudio(:,1); % take only one channel

% % downsample goPro Audio to midgeAudioFs-> first upsample, then downsample
resampledGoProAudio = resample(goProAudio,10,1);
resampledGoProAudio = resample(resampledGoProAudio,1,24);

% threshold the signals
resampledGoProAudio = resampledGoProAudio(3.7e5:11e5);
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

offsetGoProAudio13 = (poissonSpacing-diffs')*1000;

averageOffsets = mean([offsetGoProAudio2,offsetGoProAudio8,offsetGoProAudio12,offsetGoProAudio13]);
stdOffsets = std([offsetGoProAudio2,offsetGoProAudio8,offsetGoProAudio12,offsetGoProAudio13]);