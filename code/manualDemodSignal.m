clear all
clc
close all

rng(1)

data = audioread('Test1.wav');
dataChan1 = data(:,1);
dataChan2 = data(:,2);
[shiftedDataChan,shift,binaryStream] = processRawSignal(dataChan1);
csvwrite('binaryStream.csv',binaryStream)

function [shiftedDataChan,shift,binaryStream] = processRawSignal(dataChan)
    dataChan(dataChan>0)=1;
    dataChan(dataChan<0)=-1;
    thresholdedDataChan = dataChan;
    binaryStream = [];
    % number of samples before the first edge of the period
    idx = find(dataChan==1,1);
    shift = idx-1;
    shiftedDataChan = thresholdedDataChan(idx:end);
    
    % 80 samples per bit
    i=1;
    while (i<(length(shiftedDataChan)-mod(length(shiftedDataChan),80)))
        startIndex = i;
        endIndex = i+79;
        chunk = shiftedDataChan(startIndex:endIndex);
        if ((sum(chunk)/length(chunk))==1)
            binaryStream = [binaryStream;ones(80,1)];
        elseif ((sum(chunk)/length(chunk))==0)
            binaryStream=[binaryStream;zeros(80,1)];
        end
        i = endIndex+1;
    end
end

