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

% COLUMN 1 of DATA: SELECT FILE NAME

i = 1;
fin = 0;
while fin == 0
    file = uigetfile('*.txt');
    if isequal(file,0)
       disp('User selected Cancel.');                 % VERSION 1
       fin = 1;                                       % comment or uncomment
    else
       DATA{i,1} = file;
       i = i+1;
    end
end


%  DATA = {...                                          % VERSION 2
%           %'nr3_1micromol.-0,25paso_v1.txt'; ...      % no sirve
%           %'nr3_1micromol.-0,25paso_v2.txt'; ...      % no sirve
%           'nr4_1micromol.-0,25paso_v1.txt'; ...
%           %'nr4_1micromol.-0,25paso_v2.txt'; ...      % no sirve
%           'nr4_1micromol.-0,25paso_v3.txt'; ...
%           'nr4_1micromol.-0,25paso_v4.txt'; ...
%           %'nr6_1micromol.-0,25paso.txt'; ...         % no sirve
%           'nr7_1micromol.-0,25paso_v1.txt'; ...
%           'nr7_1micromol.-0,25paso_v2.txt'; ...
%          'nr12_1micromol.-0,25paso_v1.txt'; ...
%           'nr12_1micromol.-0,25paso_v2.txt'; ...
%           'nr13_1micromol.-0,25paso_v1.txt'; ...
%           'nr13_1micromol.-0,25paso_v2.txt';
%           'nr15_1micromol.-0,25paso_v1.txt';
%           'nr15_1micromol.-0,25paso_v2.txt'
%     };

    for nr = 1:size(DATA,1); % running through each file
% COLUMN 2 of DATA: ORIGINAL FILE
    DATA(nr,2) = {textread(DATA{nr,1})};                      
    nr_of_data = size(DATA{nr,2},1);
    % Calculating the number of periods (since there is no data of time,
    %                                    counting the staring points (==0))
        starting_point_period = 0;
        k = 1;
        for i = 1:nr_of_data
            if isequal(DATA{nr,2}(i,1),0) 
               starting_point_period(k) = i;
               k = k + 1;
            end
        end
        k = k - 1;
    
    % eliminating the last (incomplete) period
    nr_of_data = max(starting_point_period)-1;
    % eliminating the first (incomplete) period
    nr_of_data = nr_of_data - min(starting_point_period)-1;
    % Length of one period
    length_period = starting_point_period(2)-starting_point_period(1);

% COLUMN 3 of DATA: CURRENT FOR EACH PERIOD SAVED IN ONE ROW
    DATA(nr,3) = {reshape(DATA{nr,2}(min(starting_point_period):length_period*k,2), ... % column with current data
                 length_period, ... 
                 k)};   % number of sweeps
             
% COLUMN 6 of DATA: TRIANGULAR SIGNAL FOR EACH PERIOD SAVED IN ONE ROW
    DATA(nr,6) = {reshape(DATA{nr,2}(min(starting_point_period):length_period*k,1), ... % column with triangular data
                 length_period, ... 
                 k)};   % number of sweeps             
    
             
% COLUMN 4 of DATA: NUMBER OF SWEEPS
    DATA(nr,4) = {k};
% COLUMN 5 of DATA: LENGTH OF ONE PERIOD
    DATA(nr,5) = {length_period};
% COLUMN 7 of DATA: BACKGROUND SET
    DATA(nr,7) = {background(DATA(nr,:))};
disp(DATA{nr,1});
    end

end

