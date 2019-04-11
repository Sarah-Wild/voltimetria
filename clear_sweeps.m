function [e] = clear_sweeps(e_org)
e = e_org;

mean_val = mean(max(e{1,3}(:,:)));
limit_up = mean_val*1.4;  % values chosen by me S.W., no specific value
limit_down = mean_val*0.3 ;


% Setting all sweeps until sweep 20, above or under limits to zero
for i = 1:e{1,4}
   maximum = max(e{1,3}(:,i));
   if  (i < 20) || (maximum > limit_up) || (maximum < limit_down)
           e{1,3}(:,i) = 0;
   end
end

% figure('Name',e{1,1});
% plot(max(e{1,3}(:,:))); hold on;
% plot(max(e{1,3}(:,:)));
% legend('Maxima before clear_ sweeps', ...
%        'Maxima after clear_ sweeps');
end