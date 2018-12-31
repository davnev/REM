%% REM model
%updated: 30-12-2018

function [HR, FA]=REM_main(pgeoh,pgeol,fnum,ListL,t,u,c,g)
features=fnum;                                                      % number of word features
stim=ListL/2;                                                       % 50/50 ratio of study/novel items 
hwords=geornd(pgeoh,features,ListL);                                % generate high frequency words 
lwords=geornd(pgeol,features,ListL);                                % generate low frequency words 
studyw=horzcat(hwords(:,1:(stim/2)),lwords(:,1:(stim/2)));          % study items (HF-LF)
novelw=horzcat(hwords(:,stim+1:end),lwords(:,stim+1:end));          % novel items (HF-LF)
phiS=zeros(stim,1);                                                 % odds for studied items
phiN=zeros(stim,1);                                                 % odds for novel items
responseS=ones(stim,1)*(-1);                                        % placeholder for responses (study items)
responseN=ones(stim,1)*(-1);                                        % placeholder for responses (novel items)
stim_rep=repmat(t,1,(stim/length(t)));                              % nr. of repetitions(presentations) for each stimulus
stim_pgeo=[repmat(pgeoh,1,(stim/2)),repmat(pgeol,1,(stim/2))];      % probabilities for geometric distributions (HF-LF)

%% Study Phase
[memory,stored]=REM_study(studyw,stim,features,stim_rep,u,c,stim_pgeo);    % simulate study phase

%% Test Phase
for k=1:stim     %for each studied item
    g=stim_pgeo(k);       %geometric distribution of a given stimulus (HF-LF)
    probev=studyw(:,k); %test the probe against all memory images
    [phiS(k), responseS(k)]=REM_retri(probev,features,memory,c,g);
end
for z=1:stim     %for each novel item
    g=stim_pgeo(k);       %geometric distribution of a given stimulus (HF-LF)
    probev=novelw(:,z); %test each novel item
    [phiN(z), responseN(z)]=REM_retri(probev,features,memory,c,g);
end

%% Performance Measures
% Studied
hits_HF(1)=sum(responseS([1,4,7,10,13])==1);            % Number of Hits - HF1 
hits_HF(2)=sum(responseS([2,5,8,11,14])==1);            % Number of Hits - HF2
hits_HF(3)=sum(responseS([3,6,9,12,15])==1);            % Number of Hits - HF4
hits_LF(1)=sum(responseS([16,19,22,25,28])==1);           % Number of Hits - LF1
hits_LF(2)=sum(responseS([17,20,23,26,29])==1);           % Number of Hits - LF2
hits_LF(3)=sum(responseS([18,21,24,27,30])==1);           % Number of Hits - LF4
miss_HF(1)=sum(responseS([1,4,7,10,13])==0);          % Number of Misses - HF1
miss_HF(2)=sum(responseS([2,5,8,11,14])==0);          % Number of Misses - HF2
miss_HF(3)=sum(responseS([3,6,9,12,15])==0);          % Number of Misses - HF4
miss_LF(1)=sum(responseS([16,19,22,25,28])==0);          % Number of Misses - LF1
miss_LF(2)=sum(responseS([17,20,23,26,29])==0);          % Number of Misses - LF2
miss_LF(3)=sum(responseS([18,21,24,27,30])==0);          % Number of Misses - LF4

% Novel
corj_HF=sum(responseN([1:15])==0);           % Number of Correct Reject - HF1
corj_LF=sum(responseN([16:30])==0);          % Number of Correct Reject - HF1
fa_HF=sum(responseN([1:15])==1);              % Number of False alarms - HF1
fa_LF=sum(responseN([16:30])==1);              % Number of False alarms - LF1

HR_HF=hits_HF/(5);
HR_LF=hits_LF/(5);
FA_HF=fa_HF/(15);
FA_LF=fa_LF/(15);

HR=vertcat(HR_HF,HR_LF);
FA=vertcat(FA_HF,FA_LF);

end
