function [encrypted_image] = encryption2D(image, key)
    [H, W] = size(image);
    rng(key);
    p = randperm(H*W);
    image_tmp = reshape(image.', H*W, 1);
    image_tmp = image_tmp(p);
    encrypted_image = reshape(image_tmp, W, H).';
end

