%% MEAN D AND EUBED AGREEMENT AND CORRELATION BETWEEN VSV- AND MC-ADDs
%  Assesses the agreement and correlation of mean D and EUBED  within the 
%  NLV and PTV computed for all patiens' pairs of VSV- and MC- ADDs 
%  through BAPs, RD, absolute RD, ICC, and PCC. 

%% Choose files to compare

%  Choose a VOI: NLV or PTV
VOI_name = 'NLV';

%  Choose a treatment stage: Planning or Verification
TreatmentStage = 'Planning';

%% For each patient

for patient = 1:6
    
    % Loads VSV- and MC-ADDs
    VSV  = load_untouch_nii(strcat('Patients\', int2str(patient), '\VSV\', TreatmentStage,'-ADD.nii'));
    MC   = load_untouch_nii(strcat('Patients\', int2str(patient), '\MC\', TreatmentStage,'-ADD.nii'));

    % Loads VOI 
    VOI    = load_untouch_nii(strcat('Patients\', int2str(patient), '\VOIs\', VOI_name, '.nii'));

    % Selects voxels within the VOI
    VSV_ADD_array         = VSV.img(:);
    MC_ADD_array          = MC.img(:);
    VSV_ADD_VOI           = VSV_ADD_array(VOI.img(:)~=0);
    MC_ADD_VOI            = MC_ADD_array(VOI.img(:)~=0);
    
    % Computes mean D within the VOI 
    meanDose(patient,:)         = [mean(VSV_ADD_VOI(:)) mean(MC_ADD_VOI(:))];
    
    % Computes EUBED within the VOI
    if VOI_name == 'PTV'
       % VSV
       BED   = VSV_ADD_VOI + 1/10 * 2.5/(2.5+64.2) * VSV_ADD_VOI.^2;
       EUBED(patient,1) = - 1/ 0.002 * log( sum( exp(- 0.002 *BED))/length(VSV_ADD_VOI));
       % MC
       BED   = MC_ADD_VOI + 1/10 * 2.5/(2.5+64.2) * MC_ADD_VOI.^2;
       EUBED(patient,2) = - 1/ 0.002 * log( sum( exp(- 0.002 *BED))/length(MC_ADD_VOI));
    end
    if VOI_name == 'NLV'
       % VSV
       BED = VSV_ADD_VOI + 1/10 * 1.5/(1.5+64.2) * VSV_ADD_VOI.^2;
       EUBED(patient,1) = - 1/ 0.004 * log( sum( exp(- 0.004 *BED))/length(VSV_ADD_VOI));
       % MC
       BED = MC_ADD_VOI + 1/10 * 1.5/(1.5+64.2) * MC_ADD_VOI.^2;
       EUBED(patient,2) = - 1/ 0.004 * log( sum( exp(- 0.004 *BED))/length(MC_ADD_VOI));
    end
end


%% MEAN DOSE 

% Computes 	ICC
icc_meanDose = ICC(meanDose,'A-1',0.05,0);
median_icc_meanDose = median(icc_meanDose); 
% Computes PCC
pcc_meanDose = corrcoef(meanDose);
median_pcc_meanDose = median(pcc_meanDose);
% Computes RD 
RD_meanDose   = (meanDose(:,1) - meanDose(:,2)) ./ meanDose(:,2);
median_RD_meanDose = median(RD_meanDose);
iqr_RD_meanDose    = iqr(RD_meanDose);
% Computes absolute RD 
abs_RD_meanDose   = abs((meanDose(:,1) - meanDose(:,2))) ./ meanDose(:,2);
median_RD_meanDose = median(abs_RD_meanDose);
iqr_RD_meanDose    = iqr(abs_RD_meanDose);

% Plots BAP
Mean_meanDose = (meanDose(:,1) + meanDose(:,2)) ./ 2;
figure(1)
scatter(Mean_meanDose, RD_meanDose);
hold on
yline(mean(RD_meanDose));
hold on
yline(std(RD_meanDose)*1.96 + mean(RD_meanDose));
hold on
yline(mean(RD_meanDose) - std(RD_meanDose)*1.96);

%% EUBED 

% Computes 	ICC
icc_EUBED = ICC(EUBED,'A-1',0.05,0);
median_icc_EUBED = median(icc_EUBED); 
% Computes PCC
pcc_EUBED = corrcoef(EUBED);
median_pcc_EUBED = median(pcc_EUBED);
% Computes RD 
RD_EUBED   = (EUBED(:,1) - EUBED(:,2)) ./ EUBED(:,2);
median_RD_EUBED = median(RD_EUBED);
iqr_RD_EUBED    = iqr(RD_EUBED);
% Computes absolute RD 
abs_RD_EUBED   = abs((EUBED(:,1) - EUBED(:,2))) ./EUBED(:,2);
median_RD_EUBED = median(abs_RD_EUBED);
iqr_RD_EUBED    = iqr(abs_RD_EUBED);

% Plots BAP
Mean_EUBED = (EUBED(:,1) + EUBED(:,2)) ./ 2;
figure(2)
scatter(Mean_EUBED, RD_EUBED);
hold on
yline(mean(RD_EUBED));
hold on
yline(std(RD_EUBED)*1.96 + mean(RD_EUBED));
hold on
yline(mean(RD_EUBED) - std(RD_EUBED)*1.96);