%% simulate an epidemic with the input parameters specified
%% S = 0, I = 1, T = 2, R = 3
%% IOVERN(1,:) contains the ratio of infected individuals over time
%% IOVERN(2,:)
function [IOVERN] = dualepidemic_WKLY(N, ALPHA, KI, KC, DELTAT, BETAR, BETAT, GAMMA, TOTDAYS)
CUMTIME = 0;

%% generate random contact list K/node
C = KI>0; % list of neighbours
CT = KC>0;

%% initialize states to all S except 1 I
STATE = zeros(N,1);
STATE(ceil(N.*rand),1) = 1;
%STATE(ceil(N.*rand),1) = 1;

%% start with 1 infected node
NUMI=1; NUMR=0; NUMT=0;
IOVERN(1,1) = NUMI/N;
IOVERN(2,1) = 1;
i = 2;

%% draw t for p(S->I), p(I->T) and p(T->R) and update parameters according
%% to whether a person is infected, traced or recovered first over time
week = 1;
while CUMTIME < TOTDAYS
    S = find(STATE==0);
    I = find(STATE==1);
    T = find(STATE==2);
     
    %% compute ki for all S
    allki = sum(C(S,I,week),2);
    allkt = sum(CT(I,T,week),2);
    
    % all T can become R
    kr = ones(numel(T),1);
    
    [ti tt tr] = drawt(allki, allkt, kr, ALPHA, DELTAT, BETAR, BETAT, GAMMA);    
    listusers = [S; I; T]; listtimes = [ti; tt; tr];
    mint = min(listtimes);
    if isempty(mint) 
        return; 
    end
    USER = listusers(find(listtimes == mint)); 
    STATE(USER) = STATE(USER) + 1;
    
    NUMI = sum(STATE==1); 
    NUMT = sum(STATE==2);
    NUMR = sum(STATE==3);
    
    IOVERN(1,i) = NUMI/N;
    CUMTIME = IOVERN(2,i-1) + mint*DELTAT;
    IOVERN(2,i) = CUMTIME;
    i = i+1;
    
    week = floor(CUMTIME/7) + 1;
end
