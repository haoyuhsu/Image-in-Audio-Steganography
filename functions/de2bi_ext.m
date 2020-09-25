function [B] = de2bi_ext(D)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [len, dim] = size(D);

    if (dim ~= 1)
        fprintf("ERROR! Only allow 1D!");
    else
        B_t = de2bi(abs(D));
        [col, row] = size(B_t);
        B = zeros(col, row+1);
        for i = 1:col
            if (D(i) < 0)
                B(i,row+1) = 1;
            else
                B(i,row+1) = 0;
            end
            B(i,1:row) = B_t(i,1:row);     
        end


    end
end

