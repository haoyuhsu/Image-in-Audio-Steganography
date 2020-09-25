function [decrypted_image] = decryption2D(image, key)
    [H, W] = size(image);
    rng(key);
    p = randperm(H*W);
    image_tmp = reshape(image.', H*W, 1);
    image_tmp2(p) = image_tmp(1:length(p));
    decrypted_image = reshape(image_tmp2, W, H).';
end

