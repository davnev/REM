%% REM Simulation 
% Updated: 30-12-2018
% Author: D.Neville

clear all; close all; %clear workspace and close all figures

%% Simulation parameters
runs=10000;                          % how many times the experiment should be simulated
pgeoh=0.3;                          % probability of the geometric distibution: encoding high freq. items
pgeol=0.1;                          % probability of the geometric distibution: encoding low freq. items                                             
fnum=20;                            % nr. of features used to characterise each word
ListL=60;                           % list length: how many words are used in the experiment
t=[4 7 13];                          % How many study cycles for each level
u=0.4;                              % probability of storing a feature in memory 
c=0.7;                              % probability of storing the correct feature
g=0.4;                              % probability of retrieval
sim_HR=zeros(runs,3,2);             % matrix to store hit rates rates statistics
sim_FA=zeros(runs,2);               % matrix to store false alarm rates statistics

%% Run Simulation
for irun=1:runs
    [r1, r2]=REM_main(pgeoh, pgeol,fnum,ListL,t,u,c,g);
    sim_HR(irun,:,1)=r1(1,:); %HF items
    sim_HR(irun,:,2)=r1(2,:); %LF items
    sim_FA(irun,1)=r2(1); %HF items
    sim_FA(irun,2)=r2(2); %LF items
end

%% Print & Plot results
means_HR=mean(sim_HR,1);
('HR(HF) items:'), means_HR(:,:,1)
('HR(LF) items:'), means_HR(:,:,2)

means_FA=mean(sim_FA,1);
('FA(HF) items:'), means_FA(1)
('FA(LF) items:'), means_FA(2)
