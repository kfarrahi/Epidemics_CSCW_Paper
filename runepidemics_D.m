N = 72;
ALPHA = 0.1;
DELTAT = 10^-6;
GAMMA = 0.5;
numiter = 1000;

load('K_DAILY');
%KI = mean(KI_WKLY(:,:,15:31),3);
KI = KI_DAILY(:,:,1:end);
TOTDAYS = size(KI,3);


MEANKI = mean(mean(mean(KI)));
ALPHA = 0.1*10/MEANKI;
GAMMA = 0.5;

BETAR = 0; BETAT = 0;
for i=1:numiter
    RESULTS_0_0{i} = epidemic_DAILY(N, ALPHA, KI, DELTAT, BETAR, BETAT, GAMMA, TOTDAYS);
end

BETAR = 0.02; BETAT = 0;
for i=1:numiter
    RESULTS_02_0{i} = epidemic_DAILY(N, ALPHA, KI, DELTAT, BETAR, BETAT, GAMMA, TOTDAYS);
end

for BETAT = (0.1*10/MEANKI):(0.1*10/MEANKI):(2.5*10/MEANKI)
    for i=1:numiter
        RESULTS_BETAT_0{floor(BETAT*100)}{i} = epidemic_DAILY(N, ALPHA, KI, DELTAT, BETAR, BETAT, GAMMA, TOTDAYS);
    end
end

save('RESULTS_DAILY_ALL31WKS','RESULTS_0_0','RESULTS_02_0','RESULTS_BETAT_0','TOTDAYS','DELTAT','MEANKI');