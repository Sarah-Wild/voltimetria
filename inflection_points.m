function [x1 x2] = inflection_points(data)
% data should be the second derivative of the current
% OJO! QUE TENEMOS QUE DAR EN CUENTA QUE EN smooth_corriente LAS COLUMNAS
% BAJAN

x_1 = (350:399);
x_2 = (450:549);

poly_1 = polyfit(1:size(x_1,2), data(x_1)',3);
poly_2 = polyfit(1:size(x_2,2), data(x_2)',3);

y_1 = polyval(poly_1,1:size(x_1,2));
y_2 = polyval(poly_2,1:size(x_2,2));

x1_roots = roots(poly_1)+x_1(1);
x2_roots = roots(poly_2)+x_2(1);

x1 = floor(real(x1_roots(2)));
x2 = ceil(real(x2_roots(3)));
end

