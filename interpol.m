function signal_interp = interpol(e, col)

signal_org = e{1,col};
w=20;
for n=1:size(e{1,col},2)
    for k=1:size(e{1,col},1)-w
        signal_interp(k,n) = mean(signal_org(k:k+w-1,n));
    end
end

end