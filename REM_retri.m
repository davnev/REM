%% REM model retrieval phase
%updated: 10-02-2019

function [phi, response]=REM_retri(probev,w,word_mem,c,g)
%% Parameters
features=w;
memidx=size(word_mem,2);                        % number of images in memory (== number of studied words)
lambda=zeros(memidx,1);                         % lambda vector of likelihoods per stimulus
datam=ones(features,memidx)*9;                  % placeholder for match/mismatching features- coding=(:,:,match/mismatch)
plambda=ones(features,memidx);                  % likelihood ratios

%% Calculate Matching/Mismatching feaures
for j=1:memidx %for each memory image
  for i=1:features                      %for each feature
      if word_mem(i,j)>0                   % feature stored
        if probev(i,1)==word_mem(i,j);       
          datam(i,j)=1;                 % matching feature value
        else 
          datam(i,j)=-1;                 % mismatch feature value    
        end
      else
          datam(i,j)=0;                  % no feature stored
      end
  end
end

%% Bayesian inference
for j=1:memidx
   for i=1:features       
     if datam(i,j)==1       % matching event
         plambda(i,j)=((c+(1-c)*g*((1-g).^(word_mem(i,j)-1)))/(g*((1-g).^(word_mem(i,j)-1))));
     elseif datam(i,j)==-1  % mis-matching event
         plambda(i,j)=(1-c);
     else
         plambda(i,j)=1;    % no storage event
     end
   end
   lambda(j)=prod(plambda(:,j)); %likelihood whitin image
end

phi=(1/memidx)*sum(lambda);     %odds in favor of an old over a new test item

% Response ratio for given probe
if phi>.92
   %Response='Studied item';       
    response=1;                    
elseif phi<.92
   %Response='Novel item';         
    response=0;
else
    %Chance response
    response=round(rand);
end