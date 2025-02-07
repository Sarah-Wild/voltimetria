clear all; close all;
clc;
 
%% Evaluating sensibility of electrodes
%   25.04.2019
%   Sarah Wild, Delfina Montilla

% *VARIABLE DATA:*
% 1st column - name
% 2nd column - original read data/file (.txt)
% 3rd column - current measured ~ each row represents a period 
% 4th column - number of sweeps
% 5th column - length of one period
% 6th column - triangular signal
% 7th column - background set

%% Read Files
%   To define which .txt files shall be read, please edit function:
%   *read_files.m*

DATA = read_files();

%% Clear sweeps
% Clear out sweeps that don't serve our evaluation.
% E.g. electrode got pulled out of solution, etc.

for nr = 1 : size(DATA,1); 
DATA = clear_sweeps(DATA, nr);
end

clear nr;
%% Plotting Data
%   'show' variable determines which data to plot in function:
%   *plot_data_new.m*
%   1 = Plotting all original data of one file
%   3 = Plotting current of selected sweeps (first_sweep until last_sweep)
%   4 = Plotting current of EVERY SWEEP
%   5 = Plotting current of first_sweep, 150, 250, 350, 450 and last_sweep
%                    !!! in plot_data_new already edited to first +20 
%                    !!! because first 20 sweeps deleted in above function

    show = 3;
             % show only files: number
    a = 1;                    % FROM
    b = size(DATA,1);         % UNTIL    of  MATLAB variable 'DATA'
                              % size(DATA,1)
    
    n = 100;                  % 100
for file = a:b
        
    first_sweep = DATA{file,7}+1;   % DATA{file,7} Background +1
    last_sweep = DATA{file,4};      % DATA{file,4} End || first_sweep+n
    
    x1 = 1;                         % 1             x1 - x2: time frame
    x2 = DATA{file,5};              % DATA{file,5}            in period

    plot_data_new(show, DATA(file,:), ...
                  first_sweep, last_sweep, ...
                  x1, x2);
end

clear show file first_sweep last_sweep x1 x2 a b n;
clc;

%% Interpolar (copy pasted sergios smooth calculation)

nr = 1;
figure;
DATA{nr,8} = interpol(DATA(nr,:));

plot(DATA{nr,8}(:,50:150:600));
title('interpolated curves');

%% 
% Calculate Differential and find puntos de inflexi�n (x1 y x2)
% after that rotate

signal_c=DATA{nr,8};

for i=70:130
    curva0=mean(signal_c(:,i),2);
end    

for i=230:280
    curva1=mean(signal_c(:,i),2);
end

for i=350:400
    curva2=mean(signal_c(:,i),2);
end

for i=540:600
    curva3=mean(signal_c(:,i),2);
end

CURVAS=[curva0,curva1,curva2,curva3];

figure('Name',DATA{nr,1});

for i=1:4
    
    x1=410;                 %%%Primer punto de inflexion
    x2=490;                 %%%Segundo punto de inflexion
    pico_DA(:,i)=CURVAS(x1:x2,i)-ones(length(x1:x2),1)* CURVAS(x1,i);
    y1=CURVAS(x1,i);
    y2=CURVAS(x2,i);
    m=(y2-y1)/(x2-x1);
    alfa=atan(m);
    R=[cos(alfa) -sin(alfa);sin(alfa) cos(alfa)];
    aux=[(1:size(pico_DA,1))' pico_DA(:,i)]*R;
    pico_DA(:,i)=aux(:,2);
    plot(pico_DA(:,i)); hold on
    legend('nada','100','200','300');
    title('Picos');
%     waitforbuttonpress
end

ranksum(pico_DA(:,1),pico_DA(:,2))
ranksum(pico_DA(:,1),pico_DA(:,3))
ranksum(pico_DA(:,1),pico_DA(:,4))

