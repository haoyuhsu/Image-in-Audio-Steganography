function [x_re] = decryptionDWT(y, n_samples, n_embedded, scaled)
    audio_sig = y(1:n_samples);
    level = floor(log2(n_samples/n_embedded));
    coef = zeros(2*level+1, n_samples);

    [LoD, HiD, LoR, HiR] = wfilters('db12');
    coef(1, :) = audio_sig;

    % decomposition
    idx = 1;
    cur_size = n_samples;
    for i = 1:level
        preCD = coef(idx, 1:cur_size);
        [newCA, newCD] = dwt(preCD, LoD, HiD);
        coef(idx+1, 1:length(newCA)) = newCA;
        coef(idx+2, 1:length(newCD)) = newCD;
        idx = idx + 2;
        cur_size = ceil(cur_size/2);
    end

    % encrypted message
    x_re = coef(2*level+1, 1:n_embedded)*scaled;
end

