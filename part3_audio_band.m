clear; close all; clc;
[~, s, Fs, ~, N] = load_project_data();

soundsc(s, Fs);

S = fft(s);
k = 0:(floor(N/2)-1);
f = k*Fs/N;

magdB = 20*log10(abs(S(1:length(k))) + 1e-12);

figure;
plot(f, magdB, 'LineWidth', 1);
grid on;
xlabel('Frequency (Hz)');
ylabel('|S[k]| (dB)');
title('Part (iii): Spectrum of roar.wav');
saveas(gcf,'part3_audio_spectrum.png');

thresh = max(magdB) - 60;
idx = find(magdB >= thresh);

k_low = k(idx(1));
k_high = k(idx(end));
f_low = f(idx(1));
f_high = f(idx(end));

disp('Part (iii)');
disp(['Band within 60 dB of max, index form: [', num2str(k_low), ', ', num2str(k_high), ']']);
disp(['Band within 60 dB of max, Hz form: [', num2str(f_low), ', ', num2str(f_high), '] Hz']);