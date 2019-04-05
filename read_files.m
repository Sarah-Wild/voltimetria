function [DATA] = read_files()
%% 14.03.2019 Reading data
% VARIABLE DATA:
% 1st column - name
% 2nd column - original read data/file (.txt)
% 3rd column - current measured ~ each row represents a period 
% 4th column - number of sweeps
% 5th column - length of one period
% 6th column - triangular signal
% 7th column - sweep in which background was set in program SCOPE (laboratory)

% COLUMN 1 of DATA: FILE NAME
DATA = {...
          'nr3_1micromol.-0,25paso_v1.txt'; ...
          'nr3_1micromol.-0,25paso_v2.txt'; ...
          'nr4_1micromol.-0,25paso_v1.txt'; ...
%           'nr4_1micromol.-0,25paso_v2.txt'; ...
          'nr4_1micromol.-0,25paso_v3.txt'; ...
          'nr4_1micromol.-0,25paso_v4.txt'; ...
          'nr6_1micromol.-0,25paso.txt'; ...
          'nr7_1micromol.-0,25paso_v1.txt'; ...
          'nr7_1micromol.-0,25paso_v2.txt'; ...
          'nr12_1micromol.-0,25paso_v1.txt'; ...
          'nr12_1micromol.-0,25paso_v2.txt'; ...
          'nr13_1micromol.-0,25paso_v1.txt'; ...
          'nr13_1micromol.-0,25paso_v2.txt';
          'nr15_1micromol.-0,25paso_v1.txt';
          'nr15_1micromol.-0,25paso_v2.txt'
    };
 
nr_of_files = size(DATA,1);

    for e = 1:nr_of_files % running through each file
% COLUMN 2 of DATA: ORIGINAL FILE
    DATA(e,2) = {textread(DATA{e,1})};                      
    nr_of_data = size(DATA{e,2},1);
    % Calculating the number of periods (since there is no data of time,
    %                                    counting the staring points (==0))
        starting_point_period = 0;
        k = 1;
        for i = 1:nr_of_data
            if isequal(DATA{e,2}(i,1),0) 
               starting_point_period(k) = i;
               k = k + 1;
            end
        end
        k = k - 1;
        
    nr_of_data = max(starting_point_period)-1; % eliminating the last (incomplete) period
    nr_of_data = nr_of_data - min(starting_point_period)-1; % eliminating the first (incomplete) period
    % Length of one period
        length_period = starting_point_period(2)-starting_point_period(1);
        
    disp(DATA{e,1});
    % disp(['Number of periods: ', num2str(k), ' (sweeps).']);
    % disp(['Length of a period: ', num2str(length_period), '.']);

% COLUMN 3 of DATA: CURRENT FOR EACH PERIOD SAVED IN ONE ROW
    DATA(e,3) = {reshape(DATA{e,2}(min(starting_point_period):length_period*k,2), ... % column with current data
                 length_period, ... 
                 k)};   % number of sweeps
             
% COLUMN 6 of DATA: TRIANGULAR SIGNAL FOR EACH PERIOD SAVED IN ONE ROW
    DATA(e,6) = {reshape(DATA{e,2}(min(starting_point_period):length_period*k,1), ... % column with triangular data
                 length_period, ... 
                 k)};   % number of sweeps             
    
             
% COLUMN 4 of DATA: NUMBER OF SWEEPS
    DATA(e,4) = {k};
% COLUMN 5 of DATA: LENGTH OF ONE PERIOD
    DATA(e,5) = {length_period};
% COLUMN 7 of DATA: BACKGROUND SET
    DATA(e,7) = {background(DATA,e)};
    end
end

