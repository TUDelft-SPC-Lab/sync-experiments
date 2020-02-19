clear all
clc
close all

rng(1)

% txData = randi([0 1],50,1)
data = audioread('Test1.wav');
% dpbpskdemod = comm.DBPSKDemodulator;
% rxData = dpbpskdemod(data(:,1));
data = data(:,1);
k= bpsk(data,2400,48000,2400);
k= k';
% segment of rxData
% rxDataSeg = rxData(1:400000);

[a] = findSyncWord(k);

% %% find maximum length of zeros and ones in an arra after shifting
% % input: array, shifting range
% % % output: length of 1s and length of 0s
% % function [length1, length0] = findMaximumLengths(arr,shiftRangeMax)
% % for i = 1:shiftRangeMax
% %     
% % end
% % end
% 
%% finding the sync word
function [idxStart] = findSyncWord(arr)
    syncWord = '0011111111111101';
    arr = sprintf('%i',arr);
    idxStart = strfind(arr,syncWord);
end


function [k] = bpsk(x,fc,fs,br)
%x is received signal input file usually *.mat file
%fc is carrier frequency in Hz
%fs is sampling frequency in Hz
%br is bitrate in Hz
%the command should be like this:
%load input file
%then type bpsk(x,1000,8000,100) in command window
%means that x is the input, fc=1000Hz, fs=8000Hz, bitrate=100Hz
%Author: Mohamad Zuhairi Ismail
%UTM Skudai, Malaysia
%mohamad.zuhairi@yahoo.com
onebit=fs/br; %number of samples per bit
n=(length(x)-1)/onebit; %number of bits transmitted
b=onebit;
c=1;
k=[];
for m=1:n; %iteration from 1 to number of bits
y=x(c:b); % take the needed signal for one bit
q=cos(2*pi*((c:b)-1)*fc/fs); %reference signal for Quadrature
i=-cos(2*pi*((c:b)-1)*fc/fs); %reference signal for Inphase
a=y.*q; % (received signal) . (reference signal for Quadrature)
d=y.*i; % (received signal) . (reference signal for Inphase)
t= sum(a)-sum(d); %constellation
if t>0;
    p=ones(1,onebit); %create output (1) for the length of one bit
else
    p=zeros(1,onebit); %create output (0) for the length of one bit
end
k=[k p]; %accumulate the value of output into k
b=b+onebit; %update the value of b for the next input
c=c+onebit; %update the value of c for the next input
end
subplot(2,1,1); plot(x);grid on; %plot the input signal on the same graph
axis([0 n*onebit -1.5 1.5]); % specify the height and the witdh of the axis
subplot(2,1,2);plot(k,'LineWidth',1.5);grid on; %plot the output (bpsk signal)
axis([0 n*onebit -0.5 1.5]);
end
