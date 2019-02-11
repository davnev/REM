%% REM model generate predictions function
%updated: 10-02-2019

function [HR, FA]=REM_pred(gHF,gLF,w,ListL,t,t0,u,a,c,g)
%% Fixed parameters
ntests=1000;                        %how many data points to generate for retrieval

%% Other parameters
features=w;                                                      % number of word features
nstim=ListL/2;                                                      % number of study items: 50/50 ratio of study/novel items 
hwords=geornd(gHF,features,ListL);                                % generate high frequency words 
lwords=geornd(gLF,features,ListL);                                % generate low frequency words 
studyw=horzcat(hwords(:,1:(nstim/2)),lwords(:,1:(nstim/2)));          % study items (HF-LF)
novelw=horzcat(hwords(:,nstim+1:end),lwords(:,nstim+1:end));          % novel items (HF-LF)
phiS=zeros(nstim,1);                                                 % odds for studied items
phiN=zeros(nstim,1);                                                 % odds for novel items
responseS=ones(nstim,1)*(-1);                                        % placeholder for responses (study items)
responseN=ones(nstim,1)*(-1);                                        % placeholder for responses (novel items)
stim_t=repmat(t,1,(nstim/length(t)));                              % units of time for item repetitions(presentations) for each stimulus
stim_c=[repmat(c,1,(nstim/2)),repmat(c,1,(nstim/2))];             % standard correct storage probability
stim_u=[repmat(u,1,(nstim/2)),repmat(u,1,(nstim/2))];             % standard encoding probability    

%% Study Phase
[word_mem]=REM_study(studyw,nstim,features,stim_t,stim_u,stim_c,g,a,t0);    % simulate study phase

%% Test Phase
for k=1:nstim              %for each studied item
    probev=studyw(:,k); %test the probe against all memory images
    phiS_n=zeros(ntests,1);
    responseS_n=zeros(ntests,1);
    for itest=1:ntests
      [phiS_n(itest,1), responseS_n(itest,1)]=REM_retri(probev,features,word_mem,c,g);
    end
    phiS(k)=mean(phiS_n); %mean likelihood ratio
    responseS(k)=mean(responseS_n); %mean reponse
end

for z=1:nstim     %for each novel item
    probev=novelw(:,z); %test each novel item
    phiN_n=zeros(ntests,1);
    responseN_n=zeros(ntests,1);
    for itest=1:ntests
      [phiN_n(itest,1), responseN_n(itest,1)]=REM_retri(probev,features,word_mem,c,g);
    end
    phiN(z)=mean(phiN_n);  %mean likelihood ratio
    responseN(z)=mean(responseN_n); %mean reponse
end

%% HRs & FARs

% Studied
hits_HF(1)=sum(responseS([1:3:(nstim/2)])==1);            % Number of Hits - HF1 
hits_HF(2)=sum(responseS([2:3:(nstim/2)])==1);            % Number of Hits - HF4
hits_HF(3)=sum(responseS([3:3:(nstim/2)])==1);            % Number of Hits - HF4
hits_LF(1)=sum(responseS([16:3:(nstim)])==1);           % Number of Hits - LF1
hits_LF(2)=sum(responseS([17:3:(nstim)])==1);           % Number of Hits - LF1
hits_LF(3)=sum(responseS([18:3:(nstim)])==1);           % Number of Hits - LF1

miss_HF(1)=sum(responseS([1:3:(nstim/2)])==0);            % Number of Hits - HF1 
miss_HF(2)=sum(responseS([2:3:(nstim/2)])==0);            % Number of Hits - HF4
miss_HF(3)=sum(responseS([3:3:(nstim/2)])==0);            % Number of Hits - HF4
miss_LF(1)=sum(responseS([16:3:(nstim)])==0);           % Number of Hits - LF1
miss_LF(2)=sum(responseS([17:3:(nstim)])==0);           % Number of Hits - LF1
miss_LF(3)=sum(responseS([18:3:(nstim)])==0);           % Number of Hits - LF1

% Novel
corj_HF=sum(responseN([1:(nstim/2)])==0);           % Number of Correct Reject - HF1
corj_LF=sum(responseN([((nstim/2)+1):nstim])==0);          % Number of Correct Reject - LF1
fa_HF=sum(responseN([1:(nstim/2)])==1);              % Number of False alarms - HF1
fa_LF=sum(responseN([((nstim/2)+1):nstim])==1);              % Number of False alarms - LF1

HR_HF=hits_HF/((nstim/2)/3);
HR_LF=hits_LF/((nstim/2)/3);
FA_HF=fa_HF/(nstim/2);
FA_LF=fa_LF/(nstim/2);

HR=vertcat(HR_HF,HR_LF);
FA=vertcat(FA_HF,FA_LF);
end
