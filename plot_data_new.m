function [] = plot_data_new(show, e, first_sweep, last_sweep, x1, x2)

% In this plot_data_new function the user can 
% decide which file (e - cell array of one file) to be plotted and also which
% sweeps (first_sweep and last_sweep) and also in which
% time range (x1 and x2).
    figure('Name',e{1});
    
% Plotting Data
%   'show' variable determines which data to plot in function:
%   *plot_data_new.m*
%   1 = Plotting all data of one file
%   3 = Plotting selected sweeps (first_sweep - last_sweep)over another
    step = 1;  
%   4 = Plotting current of EVERY SWEEP
%   5 = Plotting current of first_sweep, 150, 250, 350, 450 and last_sweep
    
    %% Plotting all data 
    if show == 1
        m = size(e{2},2);          % number of .txt file columns 
        n = 1;
            
        for j = 1:m      % run through each column (triangular, current, voltage) ???
            subplot(m,n,j);
            plot(e{2}(:,j)); % plot data from actual column j
            grid on;
        end
    end
    
    %% Plotting selected sweeps (first_sweep - last_sweep)over another
    if show == 3 
            plot(e{3}(:,first_sweep:step:last_sweep));
                title({['Current of sweep ', num2str(first_sweep), ' - ', ...
                        num2str(last_sweep)], ['in given range: ', ...
                        num2str(x1), ' - ', num2str(x2)]});
                xlabel('point of time in period');
                xlim([x1 x2]);
                ylabel('current [\muA]');
            grid on;
            
    end
    
    %% Plotting current of EVERY SWEEP
    if show == 4
            plot(e{3})
                title('Current of each period');
                xlabel('point of time in period'); 
                ylabel('current [\muA]');
            grid on;
    end
    
    %% Plotting current of first_sweep, 150, 250, 350, 450 and last_sweep
    if show == 5
            plot(e{3}(:,first_sweep+20)); hold on;
            plot(e{3}(:,150)); 
            plot(e{3}(:,250)); 
            plot(e{3}(:,350)); 
            plot(e{3}(:,450));
            plot(e{3}(:,last_sweep)); 
                legend('first sweep - sin tirar','sweep 150 - tiramos 250nano', ...
                        'sweep 250 - tiramos 500 nano','sweep 350 - tiramos 750nano', ...
                        'sweep 450 - tiramos ultima vez 1micro','last sweep');
                title({'Current of several periods:', ... 
                        [num2str(first_sweep+20), ' - ', num2str(last_sweep)]});
                xlabel('point of time in period');
                xlim([x1 x2]);
                ylabel('current [\muA]');
            grid on;
    end

end





