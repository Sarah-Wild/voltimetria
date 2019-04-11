function [background_set] = background(e)
% Searching when Background was set ~ SCOPE Program
find_sweep = e{3} == 0;
k = 1;
found(1) = 0;

for i = 1:e{4}
    if sum(find_sweep(:,i)) == e{5}
        found(k) = i;
        k = k + 1;
    end
end
background_set = found(1);
end

