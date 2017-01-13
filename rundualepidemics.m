clear;
N = 72;
ALPHA = 0.1;
DELTAT = 10^-6;
GAMMA = 0.5;
numiter = 1000;

load('K_WKLY');
%KI = mean(KI_WKLY(:,:,15:31),3);
KI = KI_WKLY(:,:,1:31);
KC = KC_WKLY(:,:,1:31);
TOTDAYS = size(KI,3)*7;


MEANKI = mean(mean(mean(KI)));
MEANKC = mean(mean(mean(KC)));

ALPHA = 0.1*10/MEANKI;
GAMMA = 0.5;

BETAR = 0; BETAT = 0;
for i=1:numiter
    RESULTS_0_0{i} = dualepidemic_WKLY(N, ALPHA, KI, KC, DELTAT, BETAR, BETAT, GAMMA, TOTDAYS);
end

BETAR = 0.02; BETAT = 0;
for i=1:numiter
    RESULTS_02_0{i} = dualepidemic_WKLY(N, ALPHA, KI, KC, DELTAT, BETAR, BETAT, GAMMA, TOTDAYS);
end

for BETAT = (0.1*10/MEANKC):(0.1*10/MEANKC):(2.5*10/MEANKC)
    for i=1:numiter
        RESULTS_BETAT_0{floor(BETAT*100)}{i} = dualepidemic_WKLY(N, ALPHA, KI, KC, DELTAT, BETAR, BETAT, GAMMA, TOTDAYS);
    end
end

save('RESULTSDUAL_WKLY_ALL31WKS','RESULTS_0_0','RESULTS_02_0','RESULTS_BETAT_0','TOTDAYS','DELTAT','MEANKI','MEANKC');