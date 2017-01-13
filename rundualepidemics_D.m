clear;
N = 72;
ALPHA = 0.1;
DELTAT = 10^-6;
GAMMA = 0.5;
numiter = 1000;

load('K_DAILY');
%KI = mean(KI_WKLY(:,:,15:31),3);
KI = KI_DAILY(:,:,1:end);
KC = KC_DAILY(:,:,1:end);
TOTDAYS = size(KI,3);


MEANKI = mean(mean(mean(KI)));
MEANKC = mean(mean(mean(KC)));

%ALPHA = 0.1*10/MEANKI;
ALPHA = 0.1;
GAMMA = 0.5;

BETAR = 0; BETAT = 0;
for i=1:numiter
    RESULTS_0_0{i} = dualepidemic_DAILY(N, ALPHA, KI, KC, DELTAT, BETAR, BETAT, GAMMA, TOTDAYS);
end

BETAR = 0.02; BETAT = 0;
for i=1:numiter
    RESULTS_02_0{i} = dualepidemic_DAILY(N, ALPHA, KI, KC, DELTAT, BETAR, BETAT, GAMMA, TOTDAYS);
end

%for BETAT = (0.1*MEANKC/10):(0.1*MEANKC/10):(5.5*MEANKC/10)
for BETAT = 0.1:0.1:5.5
    for i=1:numiter
        RESULTS_BETAT_0{floor(BETAT*100)}{i} = dualepidemic_DAILY(N, ALPHA, KI, KC, DELTAT, BETAR, BETAT, GAMMA, TOTDAYS);
    end
end

save('RESULTSDUAL_DAILY_ALL31WKS_newALPHABETAT','RESULTS_0_0','RESULTS_02_0','RESULTS_BETAT_0','TOTDAYS','DELTAT','MEANKI','MEANKC');