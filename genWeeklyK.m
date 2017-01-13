clear;

%% load K_I on daily basis
load('/Users/katayounfarrahi/MATLAB/AnmolData_NetworkFigs/processData/K_GU_CSI_wDays.mat');  %%%%%% NOTE REDO WITH FILE K_GU_CSI_wDays %%%%%%%%%

%% load doy of flu questionnaire data (corresponding to K_I)
load('/Users/katayounfarrahi/MATLAB/AnmolData_FluValidationFigs/processing_data/EpochTimeSorted_Epi_wDates.mat');

count=1;
for i=1:size(K_I,3)
    KI_DAILY(:,:,i) = K_I(:,:,i) + K_I(:,:,i)';
    KI_DAILY(:,:,i) = KI_DAILY(:,:,i) - diag(diag(KI_DAILY(:,:,i)));
    
    KC_DAILY(:,:,i) = K_C(:,:,i) + K_C(:,:,i)';
    KC_DAILY(:,:,i) = KC_DAILY(:,:,i) - diag(diag(KC_DAILY(:,:,i)));
    
    KS_DAILY(:,:,i) = K_S(:,:,i) + K_S(:,:,i)';
    KS_DAILY(:,:,i) = KS_DAILY(:,:,i) - diag(diag(KS_DAILY(:,:,i)));
    count = count+7;
end

save('K_DAILY','KI_DAILY','KC_DAILY','KS_DAILY');


count=1;
for i=1:41
    KI_WKLY(:,:,i) = sum(K_I(:,:,count:count+6),3);
    KI_WKLY(:,:,i) = KI_WKLY(:,:,i) + KI_WKLY(:,:,i)';
    KI_WKLY(:,:,i) = KI_WKLY(:,:,i) - diag(diag(KI_WKLY(:,:,i)));
    
    KC_WKLY(:,:,i) = sum(K_C(:,:,count:count+6),3);
    KC_WKLY(:,:,i) = KC_WKLY(:,:,i) + KC_WKLY(:,:,i)';
    KC_WKLY(:,:,i) = KC_WKLY(:,:,i) - diag(diag(KC_WKLY(:,:,i)));
    
    KS_WKLY(:,:,i) = sum(K_S(:,:,count:count+6),3);
    KS_WKLY(:,:,i) = KS_WKLY(:,:,i) + KS_WKLY(:,:,i)';
    KS_WKLY(:,:,i) = KS_WKLY(:,:,i) - diag(diag(KS_WKLY(:,:,i)));
    count = count+7;
end

save('K_WKLY','KI_WKLY','KC_WKLY','KS_WKLY');