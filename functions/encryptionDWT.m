function [y_re, steg_old, steg_new] = encryptionDWT(y, x, n_samples, n_embedded, scaled)
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

    steg_old = coef(2*level+1, 1:length(x));
    
    % encrypted message
    coef(2*level+1, 1:length(x)) = x/scaled;
    
    % composition
    idx = 2*level + 1;
    cur_size = ceil(n_samples/2^level);
    for i = 1:level
        preCD = coef(idx, 1:cur_size);
        preCA = coef(idx-1, 1:cur_size);
        newCD = idwt(preCA, preCD, LoR, HiR);
        coef(idx-2, 1:length(newCD)) = newCD;
        idx = idx - 2;
        cur_size = cur_size*2;
    end
    
    y_re = coef(1,:);
    steg_new = coef(2*level+1, 1:length(x));
end

