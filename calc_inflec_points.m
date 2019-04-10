function [x1, x2] = calc_inflec_points(data)
% second derivative
data = diff(data);

x_1 = [350:399];
x_2 = [450:549];

poly_1 = polyfit(1:size(x_1,2), data(x_1,550)',3);
poly_2 = polyfit(1:size(x_2,2), data(x_2,550)',3);

y_1 = polyval(poly_1,1:size(x_1,2));
y_2 = polyval(poly_2,1:size(x_2,2));

x1_roots = roots(poly_1)+x_1(1);
x2_roots = roots(poly_2)+x_2(1);

x1 = floor(real(x1_roots(2)));
x2 = ceil(real(x2_roots(3)));

figure_1 = figure;
hold on;
grid on;
plot(data(:,550),'k')
plot(x_1,data(x_1,550),'b');
plot(x_1,y_1,'r');
plot(x1_roots,0,'go');
plot(x_2,data(x_2,550),'b');
plot(x_2,y_2,'r');
plot(x2_roots,0,'mo');
title(['x_1: ', num2str(x1), ' y x_2: ', num2str(x2)]);

% SDATA=DATA{nr,8};
% 
% DATA0=SDATA(:,(50:80));
% DATA0m=mode(DATA0,2); %moda de 0mol
% 
% DATA1=SDATA(:,(150:180));
% DATA1m=mode(DATA1,2); %moda de 6.25umol
% 
% DATA2=SDATA(:,(250:280));
% DATA2m=mode(DATA2,2); %moda de 12.5umol
% 
% DATA3=SDATA(:,(350:380));
% DATA3m=mode(DATA3,2); %moda de 18.75umol
% 
% DATA4=SDATA(:,(450:480));
% DATA4m=mode(DATA4,2); %moda de 25umol
% 
% DATAf=SDATA(:,(550:580));
% DATAfm=mode(DATAf,2); %moda de final

end