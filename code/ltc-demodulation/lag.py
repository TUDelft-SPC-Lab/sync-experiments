#!/usr/bin/env python3
# -*- coding:utf-8 -*-
###
# File: lag.py
# Created Date: Sunday, April 12th 2020, 12:40:34 pm
# Author: Chirag Raman
#
# Copyright (c) 2020 Chirag Raman
###


import argparse
from pathlib import Path

import numpy as np
from scipy.io import wavfile


def load_channels(fname):
    """ Return the plura, pulse channels in the audio file """
    fs, data = wavfile.read(fname)
    data = data / 32767
    data = data - data.mean(axis=0)
    return data[:, 0], data[:, 1]


def main() -> None:
    """ Entry point for the program """
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument("--audio_dir", type=str, help="audio dir")
    args = parser.parse_args()

    audio_dir = Path(args.audio_dir)
    lags = []
    for run in audio_dir.glob("*.wav"):
        c1, c2 = load_channels(run)
        corr, lag = cross_corr(c1, c2)
        lags.append(lag)
    print("lags:", lags)
    print("mean:", np.mean(lags), "std:", np.std(lags))
    print("median:", np.median(lags))


if __name__ == "__main__":
    if __package__ is None:
        import sys
        from os import path
        sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))
        from util.correlation import cross_corr
    else:
        from ..util.correlation import cross_corr
    main()
