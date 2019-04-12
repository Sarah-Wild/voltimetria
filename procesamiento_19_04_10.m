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
% 8th column - smoothened current (like 3)

%% Read Files
%   To define which .txt files shall be read, please edit function:
%   *read_files.m*

DATA = read_files();

%% Clear sweeps
% Clear out sweeps that don't serve our evaluation.
% E.g. electrode got pulled out of solution, etc.

for nr = 1 : size(DATA,1)
    DATA(nr,:) = clear_sweeps(DATA(nr,:));
end

%% Smooth curve
    a = 1;                    % FROM
    b = size(DATA,1);         % UNTIL    of  MATLAB variable 'DATA'
                              % size(DATA,1)                          
for nr = a:b
    DATA{nr,8} = smooth_corriente(DATA{nr,3});
    
    figure('Name',DATA{nr,1});
    plot(DATA{nr,8}(:,550)); % sweep 550 should show a peak
    title('smoothened curves');
    xlim([200 649]);
end

%% Delete files from DATA
f = warndlg({'Watch the plotted figures of the smoothened curves.', ...
      'If one does not show a peak delete file now in Command Window: ', ...
      'DATA(nr,:) = [] ', 'Close this Window afterwards to continue.'}, ...
      'DELETE');
drawnow
waitfor(f);


go_on = 0;
answer = questdlg('Stop running code and delete files?', 'DELETE', ...
      'Yes, stop and delete!', 'All curves are fine.', 'All curves are fine.');
% Handle response
switch answer
    case 'Yes, stop and delete!'
        disp({'Files will be deleted.'; 'Change variable go_on = 1;'} )
    case 'All curves are fine.'
        go_on = 1;
end

%% Calculate Differential and find inflection points (x1 y x2)
if go_on
    PEAK = calc_peak(DATA);
end
%% Plotting Data
%   'show' variable determines which data to plot in function:
%   *plot_data_new.m*
% Plotting Data
%   'show' variable determines which data to plot in function:
%   *plot_data_new.m*

%   0 = Don't plot anything (run through)
%   1 = Plotting all data of one file
%   3 = Plotting first_sweep - last_sweep over another 
%   4 = Plotting current of EVERY SWEEP
%   5 = Plotting current of first_sweep, 150, 
%       250, 350, 450 and last_sweep

    show = go_on;
    if go_on
    	show = 0;
    end
             % show only files: number
    a = 1;                    % FROM
    b = size(DATA,1);         % UNTIL    of  MATLAB variable 'DATA'
                              % size(DATA,1)
for nr = a:b
        
    first_sweep = DATA{nr,7}+1;   % DATA{nr,7} Background (always 0)+1
    last_sweep = DATA{nr,4};      % DATA{nr,4} End 
    
    x1 = 300;                       % 1             x1 - x2: time frame
    x2 = 600;              % DATA{nr,5}            in period

    plot_data_new(show, DATA(nr,:), ...
                  first_sweep, last_sweep, ...
                  x1, x2);
end

clear show x1 x2;
clear first_sweep last_sweep;