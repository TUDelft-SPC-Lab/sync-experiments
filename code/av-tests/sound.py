#!/usr/bin/env python3
# -*- coding:utf-8 -*-
###
# File: sound.py
# Created Date: Wednesday, February 27th 2019, 2:21:32 pm
# Author: Chirag Raman
#
# Copyright (c) 2019 Chirag Raman
###


import pyaudio
import numpy as np


p = pyaudio.PyAudio()

volume = 1  # range [0.0, 1.0]
fs = 44100       # sampling rate, Hz, must be integer
duration = 3.0   # in seconds, may be float
silenceDuration = 40.0; # in seconds
f = 20000     # sine frequency, Hz, may be float


# generate samples, note conversion to float32 array
samples = (np.sin(2*np.pi*np.arange(fs*duration)*f/fs)).astype(np.float32)

print(samples.shape)

# generate array of zeros to represent silence
zeros = np.zeros(int(silenceDuration*fs))

print(zeros.shape)

# create signal containing samples and silence 
signal = []
numRep = 0
while numRep <3:
	signal = np.concatenate((signal,samples,zeros),axis = None)
	numRep +=1 

print(signal.shape)


# for paFloat32 sample values must be in range [-1.0, 1.0]
stream = p.open(format=pyaudio.paFloat32,
                channels=1,
                rate=fs,
                output=True)


# play. May repeat with different volume values (if done interactively)
stream.write(volume*signal)

stream.stop_stream()
stream.close()

p.terminate()



