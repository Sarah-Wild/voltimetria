clear all; close all;
clc;
 
%% Evaluating sensibility of electrodes
%   05.04.2019
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

DATA{nr,8} = interpol(DATA(nr,:));

plot(DATA{nr,8}(:,50:150:600));
title('interpolated curves');

%% Interpolar (Delfi/Sarah)

SDATA=DATA{nr,8};

DATA0=SDATA(:,(50:100));
DATA0m=mode(DATA0,2); %moda de 0nmol

DATA1=SDATA(:,(200:250));
DATA1m=mode(DATA1,2); %moda de 100nmol

DATA2=SDATA(:,(350:400));
DATA2m=mode(DATA2,2); %moda de 200nmol

DATAf=SDATA(:,(530:580));
DATAfm=mode(DATAf,2); %moda de 300nmol



% xq=0:0.5:1250;
% 
% fx = interp1(DATA0m,xq);
% 
% fd= diff(fx,2);
% inflec_pt = solve(fd == 0);
% double(inflec_pt)


%% 
% Calculate Differential and find puntos de flexión (x1 y x2)
% after that rotate
% signal_c sería DATA(nr,8)

signal_c=DATA{nr,8};

signal_c_dif = diff(signal_c);
       % von allen Sweeps Zeiten von 400 bis 600 wird der erste Betrag (von
       % Zeit 400) abgezogen ~nullen und vergleichen
%pico_DA=signal_c(x1:x2,:)-ones(length(x1:x2),1)* signal_c(x1,:);

figure;
for n=50:100:600
    
%     l = 1;
%     for f = 380:540
%         if(signal_c_dif(f,n) <= 0.02 && signal_c_dif(f,n)>= -0.02)
%            x(l) = f;
%            l = l +1;
%         end
%     end
    
    x1=390;
    x2=540;
    pico_DA=signal_c(x1:x2,:)-ones(length(x1:x2),1)* signal_c(x1,:);
    y1=signal_c(x1,n);
    y2=signal_c(x2,n);
    m=(y2-y1)/(x2-x1);
    alfa=atan(m);
    R=[cos(alfa) -sin(alfa);sin(alfa) cos(alfa)];
    aux=[(1:size(pico_DA,1))' pico_DA(:,n)]*R;
    pico_DA(:,n)=aux(:,2);
    plot(pico_DA(:,n)); hold on
    legend('50','150','250','350','450','550');
    title('Picos');
%     waitforbuttonpress
end

