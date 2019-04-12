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
% 9th column - derivative of current

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

f = warndlg({'Watch the plotted figures of the smoothened curves.', ...
      'If one does not show a peak delete now in Command Window: ', ...
      'DATA(nr,:) = [] ', 'Close this Window afterwards to continue.'}, ...
      'DELETE');
drawnow
waitfor(f);

%% Calculate Differential and find inflection points (x1 y x2)

    a = 1;                    % FROM
    b = 2;         % UNTIL    of  MATLAB variable 'DATA'
                              % size(DATA,1)
    Sweep_Mode{1} = 50:80;
    Sweep_Mode{2} = 150:180;
    Sweep_Mode{3} = 250:280;
    Sweep_Mode{4} = 350:380;
    Sweep_Mode{5} = 450:480;
    Sweep_Mode{6} = 500:530;

    PEAK = DATA(:,1);
    
for nr = a:b
      disp(num2str(DATA{nr,1}));
      figure('Name',DATA{nr,1});
      title('Dopamine Peaks using mode values of sweeps');
     DATA{nr,9} = diff(DATA{nr,8})*1e5; % first derivative
     DATA{nr,9} = smooth_corriente(DATA{nr,9});
     DATA{nr,9} = diff(DATA{nr,9}); % overwriting first with second deriv. 
                                    % used for function inflection_points
      for s = 1:6
         data = DATA{nr,9}(:,Sweep_Mode{1,s}); % copy all data (2nd deriv) of selected sweeps
         Sweep_Mode{2,s} = mean(data,2); % save mode curve in Sweep_Mode row 2
         [x1,x2]  = inflection_points(Sweep_Mode{2,s}); 
         Sweep_Mode{3,s} = [x1,x2]; % save [x1 x2] inflec points for legend
         MODE = mean((DATA{nr,8}(:,Sweep_Mode{1,s})),2);
         pico_DA = MODE(x1:x2)- ...
                    ones(length(x1:x2),1)* MODE(x1);
                
        y1 = MODE(x1);
        y2 = MODE(x2);

        m = (y2-y1)/(x2-x1);
        alfa = atan(m);
        R = [cos(alfa) -sin(alfa); sin(alfa) cos(alfa)];
        aux = [(1:size(pico_DA,1))' pico_DA(:)]*R;
        pico_DA(:) = aux(:,2);
        
%         poly_aux = polyfit(pico_DA(:,1)',x1:x2,2);
%         pico_DA_aux = polyval(poly_aux, x1:x2); 
        
        disp([num2str(min(Sweep_Mode{1,s})),' - ', num2str(max(Sweep_Mode{1,s}))]);
        disp(['x1: ',num2str(x1),' | x2: ', num2str(x2)]);
        disp(['max: ', num2str(max(pico_DA))]);
        %figure;
        plot(pico_DA);
        PEAK(nr,s+1) = {max(pico_DA)};
        hold on;
        grid on;
      end
%       legend({['sweep: ', num2str(min(Sweep_Mode{1,1})), ' - ', ...
%                          num2str(max(Sweep_Mode{1,1}))]; ...
%               ['point of time: ', num2str(Sweep_Mode{3,1}(1)), ' - ', ...
%                                     num2str(Sweep_Mode{3,1}(2))]}, ...
%              {['sweep: ', num2str(min(Sweep_Mode{1,2})), ' - ', ...
%                          num2str(max(Sweep_Mode{1,2}))]; ...
%               ['point of time: ', num2str(Sweep_Mode{3,2}(1)), ' - ', ...
%                                     num2str(Sweep_Mode{3,2}(2))]}, ...
%              {['sweep: ', num2str(min(Sweep_Mode{1,3})), ' - ', ...
%                          num2str(max(Sweep_Mode{1,3}))]; ...
%               ['point of time: ', num2str(Sweep_Mode{3,3}(1)), ' - ', ...
%                                     num2str(Sweep_Mode{3,3}(2))]}, ...
%              {['sweep: ', num2str(min(Sweep_Mode{1,4})), ' - ', ...
%                          num2str(max(Sweep_Mode{1,4}))]; ...
%               ['point of time: ', num2str(Sweep_Mode{3,4}(1)), ' - ', ...
%                                     num2str(Sweep_Mode{3,4}(2))]}, ...
%              {['sweep: ', num2str(min(Sweep_Mode{1,5})), ' - ', ...
%                          num2str(max(Sweep_Mode{1,5}))]; ...
%               ['point of time: ', num2str(Sweep_Mode{3,5}(1)), ' - ', ...
%                                     num2str(Sweep_Mode{3,5}(2))]}, ...
%              {['sweep: ', num2str(min(Sweep_Mode{1,6})), ' - ', ...
%                          num2str(max(Sweep_Mode{1,6}))]; ...
%               ['point of time: ', num2str(Sweep_Mode{3,6}(1)), ' - ', ...
%                                     num2str(Sweep_Mode{3,6}(2))]});
%         legend('50 : 80', '150 : 180', '250 : 280', ...
%                '350 : 380', '450 : 480', '500 : 530');

end   
    
clear alfa m R x1 x2 y1 y2;
clear first_sweep last_sweep Sweep_Mode;
clear a b nr m n s aux;   
clear data pico_DA MODE;

%% Plotting Data
%   'show' variable determines which data to plot in function:
%   *plot_data_new.m*
% Plotting Data
%   'show' variable determines which data to plot in function:
%   *plot_data_new.m*

%   0 = Don't plot anything (run through)
%   1 = Plotting all data of one file
%   3 = Plotting first_sweep - last_sweep over another
    step = 1;  
%   4 = Plotting current of EVERY SWEEP
%   5 = Plotting current of first_sweep, 150, 
%       250, 350, 450 and last_sweep

    show = 3;
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
clear step;