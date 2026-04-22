clear; close all; clc;
[bht, s, Fs, M, N] = load_project_data();

fc = 6000;
wc = 2*pi*fc/Fs;
n = (0:N-1).';

yfull = conv(s, bht);
shat = yfull(M+1:M+N);

x = s.*cos(wc*n) - shat.*sin(wc*n);

X = fft(x);
k = 0:(N-1);
f = k*Fs/N;
magdB = 20*log10(abs(X) + 1e-12);

figure;
plot(f(1:floor(N/2)), magdB(1:floor(N/2)), 'LineWidth', 1);
grid on;
xlabel('Frequency (Hz)');
ylabel('|X[k]| (dB)');
title('Part (iv): SSB Spectrum');
saveas(gcf,'part4_ssb_spectrum.png');

S = fft(s);
magS = 20*log10(abs(S(1:floor(N/2))) + 1e-12);
kmsg = 0:(floor(N/2)-1);
fmsg = kmsg*Fs/N;
msg_idx = find(magS >= max(magS)-60);
f_low = fmsg(msg_idx(1));
f_high = fmsg(msg_idx(end));

upper_mask = (f >= fc + f_low) & (f <= fc + f_high);
lower_mask = (f >= fc - f_high) & (f <= fc - f_low);

E_total = sum(abs(X).^2);
E_upper = sum(abs(X(upper_mask)).^2);
E_lower = sum(abs(X(lower_mask)).^2);

if E_upper >= E_lower
    missing_fraction = E_lower / E_total;
    kept_side = 'upper';
    missing_side = 'lower';
else
    missing_fraction = E_upper / E_total;
    kept_side = 'lower';
    missing_side = 'upper';
end

disp('Part (iv)');
disp(['Carrier frequency = ', num2str(fc), ' Hz']);
disp(['Kept sideband appears to be the ', kept_side, ' sideband.']);
disp(['Missing sideband appears to be the ', missing_side, ' sideband.']);
disp(['Fraction of total energy in missing sideband = ', num2str(missing_fraction)]);

soundsc(x, Fs);
audiowrite('part4_ssb_output.wav', x/max(abs(x))*0.95, Fs);