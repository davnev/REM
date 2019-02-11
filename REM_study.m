%% REM model study phase
%updated: 10-02-2019

function [memory]=REM_study(studyw,nstim,features,stim_t,stim_u,stim_c,g,a,t0)
%% Parameters
memory=zeros(features,nstim);      % memory images 
stored=zeros(features,nstim);      % record of features stored

%calculate storage attempts given units of time
tmax=max(stim_t);                               % maximum number of time units
tj(1,1)=t0;                                     % number of attempts in first second of encoding
for i=2:tmax
    tj(1,i)=tj(1,i-1)*(1+exp(-a*stim_t(i)));    % number of storage attempts per units of time
end

%% Storage
for iword=1:size(studyw,2)                                          % for each word in the training set
    c=stim_c(iword);                                                % probability of correct encoding
    u=stim_u(iword);                                                % probability of storage event
    for f=1:features                                                % for each  feature
        ns=tj(stim_t(iword));                                       % number of storage attempts given word units of time
        for s=1:ns                                                  % for each storage attempt
            if(stored(f,iword)==0);                                 % if a new feature (not stored yet, no overwriting)
                rc=(round(rand(1,1)*100))/100;                      % random number for correct encoding
                ru=(round(rand(1,1)*100))/100;                      % random number for storage event            
                if ru<=(1-(1-u))                                    % storage of new feature value
                    if rc<=c                                        % correct storage
                        memory(f,iword)=studyw(f,iword);            % copy correct feature value
                        stored(f,iword)=1;                          % correct feature stored
                    else
                        memory(f,iword)=geornd(g);                  % incorrect storage (random feature from long-run base-rate distribution)
                        stored(f,iword)=-1;                         % incorrect feature stored
                    end
                end
            else
                break                                               % stop storage attempts for this feature
            end
        end
    end
end