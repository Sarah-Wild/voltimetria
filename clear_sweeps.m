function [DATA_new] = clear_sweeps(DATA_org,numero)
DATA_new = DATA_org;

mean_val = mean(max(DATA_new{numero,3}(:,:)));
limit_up = mean_val*1.4;  % values chosen by me S.W., no specific value
limit_down = mean_val*0.3 ;


% Setting all sweeps until sweep 20, above or under limits to zero
for i = 1:DATA_new{numero,4}
   maximum = max(DATA_new{numero,3}(:,i));
   if  (i < 20) || (maximum > limit_up) || (maximum < limit_down)
           DATA_new{numero,3}(:,i) = 0;
   end
end

% figure('Name',DATA_org{numero,1});
% plot(max(DATA_org{numero,3}(:,:))); hold on;
% plot(max(DATA_new{numero,3}(:,:)));
% legend('Maxima before clear_ sweeps','Maxima after clear_ sweeps');
end

