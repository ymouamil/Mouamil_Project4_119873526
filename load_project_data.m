function [bht, s, Fs, M, N] = load_project_data()
% Load filter and audio

tmp = load('b_ht.mat');
names = fieldnames(tmp);

bht = [];
for k = 1:length(names)
    val = tmp.(names{k});
    if isnumeric(val) && isvector(val)
        bht = val(:).';
        break;
    end
end

if isempty(bht)
    error('Could not find the filter vector in b_ht.mat.');
end

[s, Fs] = audioread('roar.wav');
if size(s,2) > 1
    s = mean(s,2);
end

M = (length(bht)-1)/2;
N = length(s);
end