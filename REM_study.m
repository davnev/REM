function [memory,stored]=REM_study(studyw,stim,features,stim_rep,u,c,stim_pgeo)
%% Parameters
memory=zeros(features,stim);      % memory images 
stored=zeros(features,stim);      % record of features stored

%% Storage
for iword=1:size(studyw,2) %for each word in the training set
    for irep=1:stim_rep(iword) %for each study cycle (presentation)
        randm= (round(rand(features,1)*100))/100;                       % probabilities of correct encoding
        randm2=(round(rand(features,1)*100))/100;                       % probabilities of encoding
        x=find(stored(:,iword)==0);                                     % placeholder for stored features (no overwriting)
        for s=1:length(x)
            if randm2(x(s))<=u                                          % encoding event
                if randm(x(s))<=c                                       % correct storage
                    memory(x(s),iword)=studyw(x(s),iword);   
                    stored(x(s),iword)=1;                               % correct feature stored
                else
                    memory(x(s),iword)=geornd(stim_pgeo(iword));        % incorrect storage (random feature from same distribution)
                    stored(x(s),iword)=-1;                              % incorrect feature stored
                end
            end
        end
    end
end