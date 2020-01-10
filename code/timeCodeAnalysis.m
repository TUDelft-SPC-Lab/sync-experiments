close all
clear all
clc

data = audioread('FinalTest2-5Mins.wav');
% remove initial fluctuations
data = data(200:end,:);

f1 = data(:,1);
f2 = data(:,2);

% 2 seconds
m = f1(1:(44100*2)).*f2(1:(44100*2));
% whole segment
m = f1(1:(end-44000*5)).*f2(1:end-(44000*5));
msign = sign(m);
% plot(msign);
% ylim([-2,2])

% find max length of consecutive segment of -1
count = 0;
result = 0;
for i = 1:length(msign)
    if (msign(i)==1)
        count=0;
    else
        count = count+1;
        result = max(result,count);
    end
end

msign(msign==-1)=0;
msign = msign';
dsig = diff([1 msign 1]);
startIndex = find(dsig < 0);
endIndex = find(dsig > 0)-1;
duration = endIndex-startIndex+1;

% convert max length to seconds (ms)
t = (1/44100)*result;
t_ms = t*1000;

