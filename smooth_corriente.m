function [signal_smooth] = smooth_corriente(data)

w=20;
for n=1:size(data,2)
    for k=1:size(data,1)-w
        signal_smooth(k,n) = mean(data(k:k+w-1,n));
    end
end

end

