clear; close all; clc;
[bht, ~, Fs, M, ~] = load_project_data();

Nfft = 3200;
H = fft(bht, Nfft);
w = 2*pi*(0:Nfft-1)/Nfft;

magdB = 20*log10(abs(H) + 1e-12);
phi = unwrap(angle(H))/pi;

half = 1:(Nfft/2 + 1);
w_half = w(half);
mag_half = magdB(half);

pb_mask = (w_half >= 0.05*pi) & (w_half <= 0.95*pi);
pb_w = w_half(pb_mask);
pb_mag = mag_half(pb_mask);

ripple_dB = max(pb_mag) - min(pb_mag);
w1 = pb_w(1);
w2 = pb_w(end);

f1 = w1*Fs/(2*pi);
f2 = w2*Fs/(2*pi);

figure;
plot(w_half, mag_half, 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('|H(\omega)| (dB)');
title('Part (ii): Magnitude Response');
saveas(gcf,'part2_magnitude.png');

figure;
plot(w, phi, 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('unwrap(angle(H))/\pi');
title('Part (ii): Normalized Unwrapped Phase');
saveas(gcf,'part2_phase.png');

p = polyfit(w_half(pb_mask), phi(half(pb_mask)), 1);
phase_slope = p(1);
phase_intercept = p(2);

disp('Part (ii)');
disp(['Passband used for measurements: [', num2str(w1/pi), 'pi, ', num2str(w2/pi), 'pi] rad/sample']);
disp(['Passband in Hz: [', num2str(f1), ', ', num2str(f2), '] Hz']);
disp(['Peak-to-valley ripple in that band = ', num2str(ripple_dB), ' dB']);
disp(['Phase slope (normalized by pi) = ', num2str(phase_slope)]);
disp(['Phase intercept at w = 0 (normalized by pi) = ', num2str(phase_intercept)]);
disp(['Expected delay from symmetry = M = ', num2str(M), ' samples']);