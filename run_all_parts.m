clear; close all; clc;

disp('Running Part (i)...');
run('part1_coefficients.m');

disp('Running Part (ii)...');
run('part2_frequency_response.m');

disp('Running Part (iii)...');
run('part3_audio_band.m');

disp('Running Part (iv)...');
run('part4_ssb_modulation.m');

disp('Running Part (v)...');
run('part5_demodulation.m');

disp('Done.');