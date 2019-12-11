clear all
clc
close all

[y0,Fs0] = audioread('gopro19kHz.mp3');
subplot(2,1,1);
spectrogram(y0(:,1),128,120,128,44100,'yaxis')
title('goPro-pulses at 19kHz')

[y2,Fs2] = audioread('gopro10kHz.mp3');
subplot(2,1,2);
spectrogram(y2(:,1),128,120,128,44100,'yaxis')
title('goPro-pulses at 10kHz')

% mySignal = load('mySignal.mat');
% mySignal = mySignal.mySignal;
figure
[y1,Fs1] = audioread('chan_01.wav');
spectrogram(y1,128,120,128,44100,'yaxis')
title('sennheiser microphone')


% yyaxis left
% spectrogram(y1,128,120,128,44100,'yaxis')
% 
% yyaxis right
% t = (1/(Fs1))* (1:length(y1));
% t = t/60;
% 
% t2 = (1/Fs1)*(1:length(mySignal));
% t2 = t/60;
% 
% yyaxis left
% spectrogram(y1,128,120,128,44100,'yaxis')
% hold on
% yyaxis right
% plot(t,y1,'r','LineWidth',3)
% plot(t,mySignal,'g','LineWidth',3)

% hold on
% plot(y1,'g','LineWidth',12)
% [y2,Fs2] = audioread('gopro10kHz.mp3');
% figure
% plot(y2)
% [y3,Fs3] = audioread('gopro440Hz.mp3');
% figure 
% plot(y3)
% spectrogram(y2(:,1))
% figure
% spectrogram(y2(:,1),128,120,128,48000,'yaxis')
% title('pulses at 440Hz')

 
% [y4,Fs4] = audioread('goprosound.mp3');

% figure
% spectrogram(y4(:,1),128,120,128,48000,'yaxis')
% 
% figure
% plot(y4)