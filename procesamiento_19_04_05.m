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


%% Interpolar (copy pasted sergios smooth calculation)

% data = textread('nr13_1micromol.-0,25paso_v1.txt');
% %                              period time     sweeps
% signal_c_org=reshape(data(:,2),size(data,1)/600,600);
% w=20;
% for n=1:size(signal_c_org,2)
%     for k=1:size(signal_c_org,1)-w
%         signal_c(k,n)=mean(signal_c_org(k:k+w-1,n));
%     end
% end


%% 


%% Plotting Data
%   'show' variable determines which data to plot in function:
%   *plot_data_new.m*
%   1 = Plotting all data of one file
%   2 = Plotting several periods over another with signal
%   3 = Plotting several periods over another without signal
%   4 = Plotting current of each period over another
%   5 = Plotting current of periods
%   6 = Plotting like 3 but with mean value

    show = 3;
    a = 9; 
    b = 9;           % analyse row numbers of DATA ~ files
    m = 1;         % 0, 100, 150, 200, 250, 300
    n = 100;          % 100
for file = a:b
        
    first_sweep = DATA{file,7}+m;       % DATA{file,7}+m Background 
    last_sweep = DATA{file,4};      % DATA{file,4} End || first_sweep+n
    x1 = 1;              % 1 
    x2 = DATA{file,5};              % DATA{file,5} 

    plot_data_new(show, DATA(file,:), ...
                  first_sweep, last_sweep, ...
                  x1, x2);
end

clear show file first_sweep last_sweep x1 x2 a b;
clc;
