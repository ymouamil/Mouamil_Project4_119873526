# Project 4 - Hilbert Transformer and SSB

This folder is set up so each part can run on its own.

## Files

- `b_ht.mat`
- `roar.wav`
- `load_project_data.m`
- `part1_coefficients.m`
- `part2_frequency_response.m`
- `part3_audio_band.m`
- `part4_ssb_modulation.m`
- `part5_demodulation.m`
- `run_all_parts.m`

## How to run

Open MATLAB in this folder and run any script directly.

If you want everything in order, run:

```matlab
run_all_parts
```

## Notes

- The filter vector is loaded from `b_ht.mat`.
- The script looks for the numeric vector automatically, so the variable name inside the MAT file does not have to be changed by hand.
- The filter length is 81, so `M = 40`.
- `roar.wav` is sampled at 32000 Hz.

## What each part does

### Part (i)
Plots the FIR coefficients and overlays `2/(pi(t-M))` on the right half.

### Part (ii)
Computes the 3200-point zero-padded DFT, plots magnitude in dB and unwrapped phase, and prints the passband/ripple measurements.

### Part (iii)
Loads the audio, plays it, computes its DFT, and finds the band that stays within 60 dB of the peak.

### Part (iv)
Uses the FIR Hilbert transformer in the SSB modulator, trims the convolution delay correctly, computes the FFT of the output, and saves a playback file.

### Part (v)
Shifts the SSB signal back toward baseband and makes a demodulated version for listening.

up to 100 files at once, so command line is the safer one-shot route even for normal projects. citeturn122582search5
