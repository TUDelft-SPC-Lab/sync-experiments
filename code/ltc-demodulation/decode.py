#!/usr/bin/env python3
# -*- coding:utf-8 -*-
###
# File: decode.py
# Created Date: Thursday, February 20th 2020, 1:42:51 pm
# Author: Chirag Raman
#
# Copyright (c) 2020 Chirag Raman
###


def decode_to_timecode(frame: bytes) -> str:
    """ Decodes the set of eighty bits into a timecode

    Args:
        bits    : the list of eighty bits denoting a timecode

    Returns the timecode string of the format "HH:MM:SS:FF"

    """
    assert len(frame) == 10, "provided frame should be 80 bits long"
    #assert(), "last two bytes of frame must match sync word 0x3ffd"
    frame_units = (frame[0] & 0xf0) >> 4
    frame_tens = (frame[1] & 0xc0) >> 6
    sec_units = (frame[2] & 0xf0) >> 4
    sec_tens = (frame[3] & 0xe0) >> 5
    min_units = (frame[4] & 0xf0) >> 4
    min_tens = (frame[5] & 0xe0) >> 5
    hour_units = (frame[6] & 0xf0) >> 4
    hour_tens = (frame[7] & 0xc0) >> 6
    timecode = (
        f"{hour_tens}{hour_units}:{min_tens}{min_units}:"
        f"{sec_tens}{sec_units}:{frame_tens}{frame_units}"
    )
    return timecode


def compare_frames(frame1, frame2):
    """ Returns True if the two provided frames denote the same timecode

    Args:
        frame1  : The first sequence of eighty bits to compare
        frame2  : The second sequence of eighty bits to compare

    """
    return decode_to_timecode(frame1) == decode_to_timecode(frame2)


def main() -> None:
    """ Entry point for the program """


if __name__ == "__main__":
    main()
