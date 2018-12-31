function [phi, response]=REM_retri(probev,features,memory,c,g)
%% Parameters
memidx=size(memory,2);                          % number of images in memory
lambda=zeros(memidx,1);                         % lambda vector of likelihoods per stimulus
datam=ones(features,memidx)*9;                   % placeholder for match/mismatching features- coding=(:,:,match/mismatch)
plambda=ones(features,memidx);                  % probability of feature

%% Calculate Matching/Mismatching feaures
for j=1:memidx %for each memory image
  for i=1:features
      if memory(i,j)>0                   % feature stored
        if probev(i,1)==memory(i,j);       
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
   for i=features       
     if datam(i,j)==1       % matching event
         plambda(i,j)=((c+(1-c)*g*((1-g).^(memory(i,j)-1)))/(g*((1-g).^(memory(i,j)-1))));
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
if phi>1
   %Response='Studied item';       
    response=1;                    
elseif phi<1
   %Response='Novel item';         
    response=0;
else
    %Chance response
    response=round(rand);
end