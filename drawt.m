function [ti tt tr] = drawt(ki,kt,kr,alpha,dt,betar,betat,gamma)

%% draw t from the probability distribution of a person being infected over
%% time where p(S -> I) = (k*dt*alpha)(1-k*dt*alpha)^t-1 (geometric dist
%% with mean 1/C, where C = k*dt*alpha. Same logic follows for p(I -> T)
%% and p(T -> R)
ti=[]; tt=[]; tr=[];

if alpha >0
    C = alpha * ki * dt;
    mu = 1./C;
    if ~isempty(mu)
        ti = exprnd(mu,numel(ki),1);   
    end
end   
if gamma > 0
    C = gamma * dt * kr;
    mu = 1./C;
    if ~isempty(mu)
        tr = exprnd(mu,numel(kr),1);
    end
end   
if (betar > 0) || (betat > 0)
    C = betar * dt + betat * kt * dt;
    mu = 1./C;
    if ~isempty(mu)
        tt = exprnd(mu,numel(kt),1);  
    end
end
