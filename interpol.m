function signal_interp = interpol(e)

signal_org = e{1,3};
w=30;
for n=1:e{4}
    for k=1:e{5}-w
        signal_interp(k,n) = mean(signal_org(k:k+w-1,n));
    end
 end

end

