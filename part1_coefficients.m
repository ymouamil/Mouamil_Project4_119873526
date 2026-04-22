clear; close all; clc;
[bht, ~, ~, M, ~] = load_project_data();

n = 0:2*M;

figure;
bar(n, bht, 1);
hold on;
grid on;
xlabel('n');
ylabel('bht[n]');
title('Part (i): FIR Hilbert Transformer Coefficients');

t = linspace(M+1, 2*M, 1200);
plot(t, 2./(pi*(t-M)), 'LineWidth', 2);

legend('bht', '2/(\pi(t-M))', 'Location', 'best');

center_val = bht(M+1);
odd_sym_err = max(abs(bht - (-fliplr(bht))));
even_offset_vals = bht(mod((0:2*M)-M,2)==0);

disp('Part (i)');
disp(['Length = ', num2str(length(bht))]);
disp(['M = ', num2str(M)]);
disp(['Center coefficient = ', num2str(center_val)]);
disp(['Max odd-symmetry error = ', num2str(odd_sym_err)]);
disp(['Max value on even offsets from center = ', num2str(max(abs(even_offset_vals)))]);

saveas(gcf,'part1_coefficients.png');