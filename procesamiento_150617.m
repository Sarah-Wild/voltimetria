close all; clear all; clc;

data = textread('nr13_1micromol.-0,25paso_v1.txt');
%                                   period time         sweeps
%signal_t=reshape(data(:,1),size(data,1)/max(data(:,2)),max(data(:,2)));
%signal_x=reshape(data(:,2),size(data,1)/max(data(:,2)),max(data(:,2)));
signal_c_org=reshape(data(:,2),size(data,1)/600,600);
w=20;
for n=1:size(signal_c_org,2)
    for k=1:size(signal_c_org,1)-w
        signal_c(k,n)=mean(signal_c_org(k:k+w-1,n));
    end
end

signal_c_dif = diff(signal_c)*100;
       % von allen Sweeps Zeiten von 400 bis 600 wird der erste Betrag (von
       % Zeit 400) abgezogen ~nullen und vergleichen
%pico_DA=signal_c(x1:x2,:)-ones(length(x1:x2),1)* signal_c(x1,:);

figure;
for n=210:280
    
    l = 1;
    for f = 380:540
        if(signal_c_dif(f,n) <= 0.02 && signal_c_dif(f,n)>= -0.02)
           x(l) = f;
           l = l +1;
        end
    end
    x1=382;
    x2=535;
    pico_DA=signal_c(x1:x2,:)-ones(length(x1:x2),1)* signal_c(x1,:);
    y1=signal_c(x1,n);
    y2=signal_c(x2,n);
    m=(y2-y1)/(x2-x1);
    alfa=atan(m);
    R=[cos(alfa) -sin(alfa);sin(alfa) cos(alfa)];
    aux=[(1:size(pico_DA,1))' pico_DA(:,n)]*R;
    pico_DA(:,n)=aux(:,2);
    plot(pico_DA(:,n)); hold on
    title(num2str(n))
    ylim([-0.005 0.005])
%     waitforbuttonpress
end

% 
% Nacc=setxor(78:110,81);
% MNacc=pico_DA(:,Nacc);
% [X,Y] = meshgrid(1:size(MNacc,1),1:size(MNacc,2));
% [XI,YI] = meshgrid(1:0.1:size(MNacc,1),1:0.1:size(MNacc,2));
% MNacc_interp = interp2(X,Y,MNacc',XI,YI);
% 
% figure;imagesc(MNacc_interp')
% 
% 
% PFC=setxor(120:152,[125 128]);
% MPFC=pico_DA(:,PFC);
% [X,Y] = meshgrid(1:size(MPFC,1),1:size(MPFC,2));
% [XI,YI] = meshgrid(1:0.1:size(MPFC,1),1:0.1:size(MPFC,2));
% MPFC_interp = interp2(X,Y,MPFC',XI,YI);
% 
% figure;imagesc(MPFC_interp',[-1e-3,2.5e-3])
% 
