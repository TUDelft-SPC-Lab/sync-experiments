clear all
clc
close all

rng(5)

% determines the length of the signal 
numOfIntervals =   10;

% create an array of r.v sampled from a poisson distribution of lambda =3
random_sample = poissrnd(3,1,numOfIntervals);

%initialize signal
mySignal = [];

for i = 1:length(random_sample)
    mySound = generateSound(1);
    mySilence = generateSilence(random_sample(i));
    mySignal = cat(2,mySignal,mySound,mySilence);
end

% generate sound
sound(mySignal,44100)
audiowrite('myAudiosignal.wav',mySignal,44100)

% generate video
% v = VideoWriter('video')
% open(v)
hold on
counter =0;
for i = 1:length(random_sample)
    signal=generate_signal_rectangle;
%     filename_signal = strcat('signal',num2str(i),'.png');
    counter = counter+1;
    filename_signal = strcat('img',num2str(counter),'.png');
    saveas(gcf, filename_signal)
    
    for j = 1:random_sample(i)  
        silence=generate_silence_rectangle
        counter = counter+1;
%         filename_silence = strcat('silence',num2str(i),'_',num2str(j),'.png');
        filename_silence = strcat('img',num2str(counter),'.png');
        saveas(gcf, filename_silence)
    end
end

% close(v)




% size(silence)
% size(sound)

% mySignal = cat(2,mySound,mySilence);
% size(mySignal);
% 
% sound(mySignal,44100)



% while numRep<3
%     mySignal = cat(2,mySignal, mySound,mySilence);
%     numRep = numRep+1;
% end


% mySignal = rescale(mySignal, -0.015,0.01);
% plot(mySignal)


%filters out the squeaky sound
% [b,a]=butter(1,[19900,20100]/(44100/2),'bandpass');
% filteredSignal = filter(b,a,mySignal);
% sound(filteredSignal,44100);

function [s] = generateSilence(duration)
f = 0;
fs = 44100;
ts = 1/44100;
T = duration;
t = 0:ts:T;
s = sin(2*pi*f*t);
end

function [y]=generateSound(duration)
f= 1000;
Amp=10;
fs = 44100;
ts=1/44100;
T=duration;
t=0:ts:T;
y=sin(2*pi*f*t);

end

function [signal] = generate_signal_rectangle()
signal = rectangle('Position',[1,1,5,10],'FaceColor','y','EdgeColor','b',...
    'LineWidth',3)
str = 'signal';
text('Position',[2 2],'string',str,'FontSize',16)
end

function [silence] = generate_silence_rectangle()
silence= rectangle('Position',[1,1,5,10],'FaceColor','k','EdgeColor','b',...
    'LineWidth',3)
str = 'silence';
text('Position',[2 2],'string',str,'color','c','FontSize',16)
end


