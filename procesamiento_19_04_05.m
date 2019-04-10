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
% 8th column - interpolated current (like 3)
% 9th column - derivative of current

%% Read Files
%   To define which .txt files shall be read, please edit function:
%   *read_files.m*

DATA = read_files();

%% Clear sweeps
% Clear out sweeps that don't serve our evaluation.
% E.g. electrode got pulled out of solution, etc.

for nr = 1 : size(DATA,1)
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

    show = 4;
             % show only files: number
    a = 1;                    % FROM
    b = size(DATA,1);         % UNTIL    of  MATLAB variable 'DATA'
                              % size(DATA,1)
for nr = a:b
        
    first_sweep = DATA{nr,7}+1;   % DATA{nr,7} Background +1
    last_sweep = DATA{nr,4};      % DATA{nr,4} End 
    
    x1 = 300;                       % 1             x1 - x2: time frame
    x2 = 600;              % DATA{nr,5}            in period

    plot_data_new(show, DATA(nr,:), ...
                  first_sweep, last_sweep, ...
                  x1, x2);
end

clear show nr first_sweep last_sweep x1 x2 a b n;
close all;
clc;

%% Interpolar
    a = 1;                    % FROM
    b = size(DATA,1);         % UNTIL    of  MATLAB variable 'DATA'
                              % size(DATA,1)                          
for nr = a:b
    DATA{nr,8} = interpol(DATA(nr,:),3);
    
    figure('Name',DATA{nr,1});
    plot(DATA{nr,8}(:,550)); % sweep 550 should show a peak
    title('interpolated curves');
    xlim([200 649]);
end

f = warndlg({'Watch the plotted figures of the interpolated curves.', ...
      'If one does not show a peak delete now in Command Window: ', ...
      'DATA(nr,:) = [] ', 'Close this Window afterwards to continue.'}, 'DELETE');
drawnow
waitfor(f);
%% Calculate Differential and find puntos de flexión (x1 y x2)
% after that: rotate
    a = 1;                    % FROM
    b = size(DATA,1);         % UNTIL    of  MATLAB variable 'DATA'
                              % size(DATA,1)                          
for nr = a:b
    DATA{nr,9} = diff(DATA{nr,8})*1e5;
    DATA{nr,9} = interpol(DATA(nr,:),9);
    [x1 x2] = calc_inflec_points(DATA{nr,9});
%     x1 = 380;   % Wendepunkte, puntos de flexión                    % HACER FUNCION!!!
%     x2 = 480; 
    
pico_DA = DATA{nr,8}(x1:x2,:)-ones(length(x1:x2),1)* DATA{nr,8}(x1,:);

    first_sweep = DATA{nr,7}+1;   % DATA{nr,7} Background +1      % Sergio: 210
    last_sweep = DATA{nr,4};      % DATA{nr,4} End                % Sergio: 280

    for n = first_sweep:last_sweep
        y1 = DATA{nr,8}(x1,n);
        y2 = DATA{nr,8}(x2,n);

        m = (y2-y1)/(x2-x1);
        alfa = atan(m);
        R = [cos(alfa) -sin(alfa); sin(alfa) cos(alfa)];
        aux = [(1:size(pico_DA,1))' pico_DA(:,n)]*R;
        pico_DA(:,n) = aux(:,2);

    end
    figure('Name',DATA{nr,1});
    plot(pico_DA);
    title(['sweep: ', num2str(first_sweep), ' - ', num2str(last_sweep), ...
           ' | point of time: ', num2str(x1), ' - ', num2str(x2)]);
end

clear alfa m R x1 x2 y1 y2 first_sweep last_sweep a b nr m n aux;
clc;