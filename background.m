function [background_set] = background(DATA, e)
% Searching when Background was set ~ SCOPE Program
find_sweep = DATA{e,3} == 0;
k = 1;
found(1) = 0;

for i = 1:DATA{e,4}
    if sum(find_sweep(:,i)) == DATA{e,5}
        found(k) = i;
        k = k + 1;
    end
end
background_set = found(1);
end

