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
%   2 = Plotting several periods over another with signal               ***
%   3 = Plotting several periods over another without signal            ***
    step = 1;                                                        %  ***
%   4 = Plotting current of each period over another
%   5 = Plotting current of periods
    
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
    
    %% Plotting several periods over another with signal
    if show == 2
            subplot(2,1,1);
            plot(e{3}(x1:x2,first_sweep:step:last_sweep));
                title({['Current of sweep ', num2str(first_sweep), ' - ', ...
                        num2str(last_sweep)], ['in given range: ', ...
                        num2str(x1), ' - ', num2str(x2)]});
                xlabel('point of time in period'); 
                ylabel('current [\muA]');
            grid on;
            subplot(2,1,2);
            plot(e{6}(x1:x2,first_sweep:step:last_sweep));
                xlabel('point of time in period'); ylabel('voltage');
    end
    
    %% Plotting several periods over another without signal
    if show == 3 
            plot(e{3}(x1:x2,first_sweep:step:last_sweep));
                title({['Current of sweep ', num2str(first_sweep), ' - ', ...
                        num2str(last_sweep)], ['in given range: ', ...
                        num2str(x1), ' - ', num2str(x2)]});
                xlabel('point of time in period'); 
                ylabel('current [\muA]');
            grid on;
            
    end
    
    %% Plotting current of each period over another
    if show == 4
            plot(e{3})
                title('Current of each period');
                xlabel('point of time in period'); 
                ylabel('current [\muA]');
            grid on;
    end
    
    %% Plotting current of periods
    if show == 5
            plot(e{3}(x1:x2,first_sweep)); hold on;
            plot(e{3}(x1:x2,first_sweep + 150)); 
            plot(e{3}(x1:x2,first_sweep + 250)); 
            plot(e{3}(x1:x2,first_sweep + 350)); 
            plot(e{3}(x1:x2,first_sweep + 450));
            plot(e{3}(x1:x2,last_sweep)); 
                legend('first sweep - sin tirar','sweep 150 - tiramos 250nano', ...
                        'sweep 250 - tiramos 500 nano','sweep 350 - tiramos 750nano', ...
                        'sweep 450 - tiramos ultima vez 1micro','last sweep');
                title({'Current of two periods:', ... 
                        [num2str(first_sweep), ' - ', num2str(last_sweep)]});
                xlabel('point of time in period'); 
                ylabel('current [\muA]');
            grid on;
    end
    
    %% Plotting like 3 but with mean value
    
    
    if show == 6
            plot(e{3}(x1:x2,mean(first_sweep:step:last_sweep)));
                title({['Current of sweep ', num2str(first_sweep), ' - ', ...
                        num2str(last_sweep)], ['in given range: ', ...
                        num2str(x1), ' - ', num2str(x2)]});
                xlabel('point of time in period'); 
                ylabel('current [\muA]');
            grid on;     
            
x = x1-349:x2-349;
k = 1;
for p = first_sweep:last_sweep
y = DATA{file,3}(x1:x2,p);
poly = polyfit(x,y',3);
y_new(k,x) = (polyval(poly,x));
plot(y_new(k),'b'); hold on;
k = k+1;
end
    end
    

end





