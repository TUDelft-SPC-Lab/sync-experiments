clear all
clc
close all

rng(1)

data = audioread('run1.wav');
dataChan1 = data((192000*5+1):192000*6,1);

dataChan1(dataChan1>0)=1;
dataChan1(dataChan1<0)=-1;
idx = find(dataChan1==1,1);
dataChan1=dataChan1(idx:end);

leftover = mod(length(dataChan1),80);
dataChan1 = dataChan1(1:(length(dataChan1)-leftover));

dataChan1Reshaped = reshape(dataChan1,80,[]);
dataChan1ReshapedFirst = dataChan1Reshaped(1:40,:)*1;
dataChan1ReshapedSecond = dataChan1Reshaped(41:end,:)*(-1);
dataChan1Multiplied = [dataChan1ReshapedFirst;dataChan1ReshapedSecond];
dataChan1Summed = sum(dataChan1Multiplied,1);


% [shiftedDataChan,shift,binaryStream,count] = processRawSignal(dataChan1);
syncWord = '0011111111111101';

% syncwordIdxStart = findSyncWord(binaryStream,syncWord);
% binaryStream = binaryStream((syncwordIdxStart(1)+length(syncWord)):end);
% csvwrite('binaryStream.csv',binaryStream)

function [shiftedDataChan,shift,binaryStream,count] = processRawSignal(dataChan)
    dataChan(dataChan>=0)=1;
    dataChan(dataChan<0)=-1;
    thresholdedDataChan = dataChan;
    binaryStream = [];
    % number of samples before the first edge of the period
    idx = find(dataChan==1,1);
    shift = idx-1;
    shiftedDataChan = thresholdedDataChan(idx:end);
    
    % 80 samples per bit
    i=1;
    count = 0;
    while (i<(length(shiftedDataChan)-mod(length(shiftedDataChan),80)))
        startIndex = i;
        endIndex = i+79;
        chunk = shiftedDataChan(startIndex:endIndex);
        chunk(1:40) = chunk(1:40)*1;
        chunk(41:end) = chunk(41:end)*(-1);
        if ((sum(chunk)/length(chunk))==1)
            binaryStream = [binaryStream;ones(80,1)];
        elseif ((sum(chunk)/length(chunk))==0)
            binaryStream=[binaryStream;zeros(80,1)];
        % there are other possible values of the sum
        else
            count = count +1;
        end
        i = endIndex+1;
    end
end

%% finding the sync word
function [idxStart] = findSyncWord(arr,syncWord)
    arr = sprintf('%i',arr);
    idxStart = strfind(arr,syncWord);
end

