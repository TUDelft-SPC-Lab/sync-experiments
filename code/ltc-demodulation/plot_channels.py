#!/usr/bin/env python3
# -*- coding:utf-8 -*-
###
# File: plot_channels.py
# Created Date: Friday, April 10th 2020, 3:05:49 pm
# Author: Chirag Raman
#
# Copyright (c) 2020 Chirag Raman
###


import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
from scipy.io import wavfile

def set_style():
    sns.set_context("paper", font_scale=1.5)
    sns.set_style("ticks")

def set_size(fig):
    fig.set_size_inches(10, 6)
    plt.tight_layout(h_pad=2)

def plot_data(data, t):
    plura = data[:t, 0]
    pulse = data[:t, 1]
    fig, (ax1, ax2) = plt.subplots(2, sharex=True)
    ax1.plot(plura, "r")
    ax1.set_title("Plura ELC LTC Out", fontsize=16)
    ax2.plot(pulse, "r")
    ax2.set_title(":pulse LTC Out", fontsize=16)
    return fig, ax1, ax2

def main():
    """ Plot channels """
    set_style()
    fs, data = wavfile.read("artefacts/plura-pulse-tests/audio/run1.wav")
    data = data / 32767
    t = 2000
    fig, ax1, ax2 = plot_data(data, t)

    x = np.linspace(0, t, 9)/fs*1000
    x = np.around(x, decimals=2)
    print(x)
    ax2.set_xticks(np.linspace(0, t, 9))
    ax2.set_xticklabels(x)
    ax2.set(xlabel="time (ms)")
    ax2.xaxis.set_label_coords(0.95, -0.2)
    fig.text(0.02, 0.52, "amplitude", ha="center", va="center", rotation="vertical")

    set_size(fig)
    sns.despine()
    fig.savefig("ltc_channels.pdf", dpi=300)


if __name__ == "__main__":
    main()
