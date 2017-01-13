clear;

load 'RESULTSDUAL_DAILY_ALL31WKS_newALPHABETAT';
tottime = 200;
numsamples2plot = 1000;
stepsize = tottime/numsamples2plot;


[x ally] = meanplot(RESULTS_0_0, stepsize, tottime);
semilogy(x,mean(ally(:,1:numsamples2plot))); hold on;

[x2 ally2] = meanplot(RESULTS_02_0, stepsize, tottime);
semilogy(x2,mean(ally2(:,1:numsamples2plot)),':'); 


%for BETAT = (0.1*10/MEANKI):(0.1*10/MEANKI):(2.5*10/MEANKI)
for BETAT = (0.1):(0.1):(5.5)
    [x3 ally3] = meanplot(RESULTS_BETAT_0{floor(BETAT*100)}, stepsize, tottime);
    semilogy(x3, mean(ally3(:,1:numsamples2plot)));
end

set(gca,'fontsize',20);
ylabel('I/N'); xlabel('Time (days)'); 



%% PLOT FOR PLOS SIMILAR TO REMI FIGS
figure;
semilogy(x2,mean(ally2(:,1:numsamples2plot)),'r','Linewidth',1.1); hold on; 
BETAT_LIST = [0.1, 0.2, 0.5, 1, 1.5, 2.5];
COLOR = ['g','b','c','y','k','m'];
for i = 1:numel(BETAT_LIST)
    BETAT = BETAT_LIST(i)*10/MEANKI;
    [x3 ally3] = meanplot(RESULTS_BETAT_0{floor(BETAT*100)}, stepsize, tottime);
    semilogy(x3, mean(ally3(:,1:numsamples2plot)),COLOR(i),'Linewidth',1.1);
end

set(gca,'fontsize',20);
ylabel('I/N'); xlabel('Time (days)'); 
legend('\beta_t=0','\beta_t=0.10','\beta_t=0.20','\beta_t=0.50','\beta_t=1.00','\beta_t=1.50','\beta_t=2.50');
