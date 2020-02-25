clear all
clc
close all

numRep = 0;
mySignal = [];

mySilence = generateSilence();
mySound = generateSound();

% sound(mySound,44100)
% size(silence)
% size(sound)

% mySignal = cat(2,mySound,mySilence);
% size(mySignal);

% sound(mySignal,44100)



while numRep<3
    mySignal = cat(2,mySignal, mySound,mySilence);
    numRep = numRep+1;
end

% sound(mySignal,44100)

% class(mySignal)
% mySignal = typecast(mySignal,'single');
[b,a]=butter(1,[19900,20100]/(44100/2),'bandpass');
filteredSignal = filter(b,a,mySignal);
sound(filteredSignal,44100);

function [s] = generateSilence()
f = 0;
fs = 44100;
ts = 1/44100;
T = 2;
t = 0:ts:T;
s = sin(2*pi*f*t);
end

function [y]=generateSound()
f= 20000;
Amp=10;
fs = 44100;
ts=1/44100;
T=1;
t=0:ts:T;
y=sin(2*pi*f*t);

end


