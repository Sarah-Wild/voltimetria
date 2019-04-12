function ptos_infl = calc_inflec_points(data)
% second derivative
data = diff(data);

 DATA0=data(:,(50:80));
 DATA0m=mode(DATA0,2); %moda de 0mol
 
 DATA1=data(:,(150:180));
 DATA1m=mode(DATA1,2); %moda de 6.25umol
 
 DATA2=data(:,(250:280));
 DATA2m=mode(DATA2,2); %moda de 12.5umol
 
 DATA3=data(:,(350:380));
 DATA3m=mode(DATA3,2); %moda de 18.75umol
 
 DATA4=data(:,(450:480));
 DATA4m=mode(DATA4,2); %moda de 25umol
 
 DATAf=data(:,(550:580));
 DATAfm=mode(DATAf,2); %moda de final

 ptos_infl=zeros(6,2);
 
%puntos de inflexion de situacion inicial
x_1 = (350:399);
x_2 = (450:549);

poly_1 = polyfit(1:size(x_1,2), DATA0m(x_1)',3);
poly_2 = polyfit(1:size(x_2,2), DATA0m(x_2)',3);

y_1 = polyval(poly_1,1:size(x_1,2));
y_2 = polyval(poly_2,1:size(x_2,2));

x1_roots = roots(poly_1)+x_1(1);
x2_roots = roots(poly_2)+x_2(1);

x1 = floor(real(x1_roots(2)));
x2 = ceil(real(x2_roots(3)));

figure_1 = figure;
hold on;
grid on;
plot(DATA0m,'k')
plot(x_1, DATA0m(x_1),'b');
plot(x_1,y_1,'r');
plot(x1_roots,0,'go');
plot(x_2,DATA0m(x_2),'b');
plot(x_2,y_2,'r');
plot(x2_roots,0,'mo');
title(['x_1: ', num2str(x1), ' y x_2: ', num2str(x2)]);

ptos_infl(1,:)=[x1,x2];

%puntos de inflexion de 1ª tirada

poly_1 = polyfit(1:size(x_1,2), DATA1m(x_1)',3);
poly_2 = polyfit(1:size(x_2,2), DATA1m(x_2)',3);

y_1 = polyval(poly_1,1:size(x_1,2));
y_2 = polyval(poly_2,1:size(x_2,2));

x1_roots = roots(poly_1)+x_1(1);
x2_roots = roots(poly_2)+x_2(1);

x1 = floor(real(x1_roots(2)));
x2 = ceil(real(x2_roots(3)));

figure_2 = figure;
hold on;
grid on;
plot(DATA1m,'k')
plot(x_1, DATA1m(x_1),'b');
plot(x_1,y_1,'r');
plot(x1_roots,0,'go');
plot(x_2,DATA1m(x_2),'b');
plot(x_2,y_2,'r');
plot(x2_roots,0,'mo');
title(['x_1: ', num2str(x1), ' y x_2: ', num2str(x2)]);

ptos_infl(2,:)=[x1,x2];


%puntos de inflexion de 2ª tirada

poly_1 = polyfit(1:size(x_1,2), DATA2m(x_1)',3);
poly_2 = polyfit(1:size(x_2,2), DATA2m(x_2)',3);

y_1 = polyval(poly_1,1:size(x_1,2));
y_2 = polyval(poly_2,1:size(x_2,2));

x1_roots = roots(poly_1)+x_1(1);
x2_roots = roots(poly_2)+x_2(1);

x1 = floor(real(x1_roots(2)));
x2 = ceil(real(x2_roots(3)));

figure_3 = figure;
hold on;
grid on;
plot(DATA2m,'k')
plot(x_1, DATA2m(x_1),'b');
plot(x_1,y_1,'r');
plot(x1_roots,0,'go');
plot(x_2,DATA2m(x_2),'b');
plot(x_2,y_2,'r');
plot(x2_roots,0,'mo');
title(['x_1: ', num2str(x1), ' y x_2: ', num2str(x2)]);

ptos_infl(3,:)=[x1,x2];

%puntos de inflexion de 3ª tirada

poly_1 = polyfit(1:size(x_1,2), DATA3m(x_1)',3);
poly_2 = polyfit(1:size(x_2,2), DATA3m(x_2)',3);

y_1 = polyval(poly_1,1:size(x_1,2));
y_2 = polyval(poly_2,1:size(x_2,2));

x1_roots = roots(poly_1)+x_1(1);
x2_roots = roots(poly_2)+x_2(1);

x1 = floor(real(x1_roots(2)));
x2 = ceil(real(x2_roots(3)));

figure_4 = figure;
hold on;
grid on;
plot(DATA3m,'k')
plot(x_1, DATA3m(x_1),'b');
plot(x_1,y_1,'r');
plot(x1_roots,0,'go');
plot(x_2,DATA3m(x_2),'b');
plot(x_2,y_2,'r');
plot(x2_roots,0,'mo');
title(['x_1: ', num2str(x1), ' y x_2: ', num2str(x2)]);
>>>>>>> b7cae27b1c04f62940452a81bfff28bc055a62db

ptos_infl(4,:)=[x1,x2];
 
%puntos de inflexion de 4ª tirada

poly_1 = polyfit(1:size(x_1,2), DATA4m(x_1)',3);
poly_2 = polyfit(1:size(x_2,2), DATA4m(x_2)',3);

y_1 = polyval(poly_1,1:size(x_1,2));
y_2 = polyval(poly_2,1:size(x_2,2));

x1_roots = roots(poly_1)+x_1(1);
x2_roots = roots(poly_2)+x_2(1);

x1 = floor(real(x1_roots(2)));
x2 = ceil(real(x2_roots(3)));

figure_5 = figure;
hold on;
grid on;
plot(DATA4m,'k')
plot(x_1, DATA4m(x_1),'b');
plot(x_1,y_1,'r');
plot(x1_roots,0,'go');
plot(x_2,DATA4m(x_2),'b');
plot(x_2,y_2,'r');
plot(x2_roots,0,'mo');
title(['x_1: ', num2str(x1), ' y x_2: ', num2str(x2)]);

ptos_infl(5,:)=[x1,x2];

%puntos de inflexion de la situacion final

poly_1 = polyfit(1:size(x_1,2), DATAfm(x_1)',3);
poly_2 = polyfit(1:size(x_2,2), DATAfm(x_2)',3);

y_1 = polyval(poly_1,1:size(x_1,2));
y_2 = polyval(poly_2,1:size(x_2,2));

x1_roots = roots(poly_1)+x_1(1);
x2_roots = roots(poly_2)+x_2(1);

x1 = floor(real(x1_roots(2)));
x2 = ceil(real(x2_roots(3)));

figure_6 = figure;
hold on;
grid on;
plot(DATAfm,'k')
plot(x_1, DATAfm(x_1),'b');
plot(x_1,y_1,'r');
plot(x1_roots,0,'go');
plot(x_2,DATAfm(x_2),'b');
plot(x_2,y_2,'r');
plot(x2_roots,0,'mo');
title(['x_1: ', num2str(x1), ' y x_2: ', num2str(x2)]);

ptos_infl(6,:)=[x1,x2];


end

