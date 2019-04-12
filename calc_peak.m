function [PEAK] = calc_peak(DATA)
    a = 1;                    % FROM
    b = size(DATA,1);         % UNTIL    of  MATLAB variable 'DATA'
                              % size(DATA,1)
    Sweep_Mode{1} = 50:80;
    Sweep_Mode{2} = 150:180;
    Sweep_Mode{3} = 250:280;
    Sweep_Mode{4} = 350:380;
    Sweep_Mode{5} = 450:480;
    Sweep_Mode{6} = 500:530;

    PEAK = DATA(:,1);
    
for nr = a:b
    disp('.');
    disp(num2str(DATA{nr,1}));
    disp('Sweeps:');
    figure('Name',DATA{nr,1},'Position',[70 200 700 500]);
    title('Dopamine Peaks using mean values of sweepsections');
    hold on; grid on;
      
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
        
        if (x2 <= x1)
            pico_DA = zeros(1,80);
        end
        s_first = min(Sweep_Mode{1,s});
        s_last = max(Sweep_Mode{1,s});
        disp([num2str(s_first),' - ', num2str(s_last), ...
            ' ||| x1: ',num2str(x1),' | x2: ', num2str(x2), ...
            ' ||| max: ', num2str(max(pico_DA))]);
        
        plot(pico_DA);
        PEAK(nr,s+1) = {max(pico_DA)};

      end
      legend('50 : 80 - sin tirar', ...
             '150 : 180 - 250nano', ...
             '250 : 280 - 500nano', ...
             '350 : 380 - 750nano', ...
             '450 : 480 -   1micro', ...
             '500 : 530 - estabiliza');

end   

end

