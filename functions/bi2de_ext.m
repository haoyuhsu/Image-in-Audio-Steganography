function [D] = bi2de_ext(B)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    [len, dim] = size(B);
    D_t = bi2de(B(:,1:dim-1));
    D = zeros(len, 1);
    for i = 1:len
        if (B(i,dim) == 0)
            D(i) = D_t(i);
        else
            D(i) = -D_t(i);
        end   
    end
end

