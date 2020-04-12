#!/usr/bin/env python3
# -*- coding:utf-8 -*-
###
# File: correlation.py
# Created Date: Sunday, April 12th 2020, 1:02:12 pm
# Author: Chirag Raman
#
# Copyright (c) 2020 Chirag Raman
###


import numpy as np
from scipy.signal import correlate


def cross_corr(y1, y2):
    """Calculates the cross correlation and lags without normalization.

    The definition of the discrete cross correlation is in:
    https://www.mathworks.com/help/matlab/ref/xcorr.html

    Args:
        y1, y2: Should have the same length.

    Returns:
        corr        : The correlation between the signals without normalization
        lag         : The lag in terms of the index.
    """
    if len(y1) != len(y2):
        raise ValueError('The lengths of the inputs should be the same.')

    y1_auto_corr = np.dot(y1, y1) / len(y1)
    y2_auto_corr = np.dot(y2, y2) / len(y1)
    corr = correlate(y1, y2, mode="same")
    # The unbiased sample size is N - lag.
    unbiased_sample_size = correlate(
        np.ones(len(y1)), np.ones(len(y1)), mode="same")
    corr = corr / unbiased_sample_size / np.sqrt(y1_auto_corr * y2_auto_corr)
    shift = len(y1) // 2

    max_corr = np.max(corr)
    argmax_corr = np.argmax(corr)
    return corr, argmax_corr - shift