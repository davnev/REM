%% REM Simualtion Script
% Updated: 10-02-2019

clear all; close all; %clear workspace and close all figures

%% Simulation parameters
w=16;                            % nr. of features used to characterise each word
ListL=120;                           % list length: how many words are used in the experiment
t=[7 10 16];                           % encoding units of time based on number of items repetitions [1,2,4]
t0=4;                                 % amount of storage for first second of encoding
u=0.027;                              % probability of storing a feature in memory 
c=0.27;                              % probability of storing the correct feature
g=0.40;                             % long-run base rate geometric distribution gHF>g>gLF
gHF=0.45;                           % high-frequency items rate geometric distribution
gLF=0.325;                           % low-frequency items rate geometric distribution
a=0.8;                                %rate parameter for number of attempts at storing a feature
sim_HR=zeros(1,3,2);             % matrix to store hit rates rates statistics
sim_FA=zeros(1,2);               % matrix to store false alarm rates statistics

%generate predictions 
[r1, r2]=REM_pred(gHF,gLF,w,ListL,t,t0,u,a,c,g); 
sim_HR(1,:,1)=r1(1,:); %HF items
sim_HR(1,:,2)=r1(2,:); %LF items
sim_FA(1,1)=r2(1); %HF items
sim_FA(1,2)=r2(2); %LF items

%% Print & Plot results

('HR(HF) items:'), sim_HR(1,:,1)
('HR(LF) items:'), sim_HR(1,:,2)

('FA(HF) items:'), sim_FA(1,1)
('FA(LF) items:'), sim_FA(1,2)
