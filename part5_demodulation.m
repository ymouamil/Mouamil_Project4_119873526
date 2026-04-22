clear; close all; clc;
[bht, s, Fs, M, N] = load_project_data();

fc = 6000;
wc = 2*pi*fc/Fs;
n = (0:N-1).';

yfull = conv(s, bht);
shat = yfull(M+1:M+N);

x = s.*cos(wc*n) - shat.*sin(wc*n);

z = x .* exp(-1j*wc*n);
Z = fft(z);

keep = zeros(size(Z));
halfband = round(4000*N/Fs);   % keeps the baseband part after shifting
keep(1:halfband+1) = Z(1:halfband+1);
keep(end-halfband+1:end) = Z(end-halfband+1:end);

sdemod = real(ifft(keep));

figure;
plot((0:N-1)/Fs, s, 'LineWidth', 1);
hold on;
plot((0:N-1)/Fs, sdemod, 'LineWidth', 1);
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Part (v): Original and Demodulated Signals');
legend('s', 'sdemod', 'Location', 'best');
saveas(gcf,'part5_demod_compare.png');

soundsc(sdemod, Fs);
audiowrite('part5_demod_output.wav', sdemod/max(abs(sdemod))*0.95, Fs);

err = norm(s - sdemod)/norm(s);

disp('Part (v)');
disp(['Relative error between s and sdemod = ', num2str(err)]);