/*
 * File: binarize_timecode.m
 * Created Date: Tuesday, February 25th 2020, 11:46:35 am
 * Author: Amelia Villegas
 *
 * Copyright (c) 2020 Amelia Villegas
 */


[data, fs] = audioread('run1.wav');

dataChan1 = data(:,1);

idx = 33;
dataChan1 = dataChan1(idx+fs:idx+2*fs-1);
% dataChan1 = dataChan1(idx:idx+83*80);
% [p, loc] = findpeaks(dataChan1, 'MinPeakDistance', 30);

res = reshape(dataChan1, 40, []);
s = sum(res,1);
sth = s;
sth(s<0) = -1;
sth(s>0) = 1;
res = reshape(sth, 2,[]);

% samp = dataChan1(20:40:end);
% sampth = samp;
% sampth(samp<0) = -1;
% sampth(samp>0) = 1;
% res = reshape(sampth, 2,[]);

mul = res(1,:) .* res(2,:);
final = mul;
final(mul==1) = 0;
final(mul==-1) = 1;

string = num2str(final, '%d');
pattern = '0011111111111101';
strfind(string, pattern)