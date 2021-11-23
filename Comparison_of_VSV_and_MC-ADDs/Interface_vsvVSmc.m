%% AGREEMENT AND CORRELATION AT LIVER INTERFACE WITH SURROUNDING TISSUES
%  Assesses the agreement between VSV- and MC-ADDs  through the RD of mean D within
%  the IN and OUT volumes.
%  Assesses the correlation between VSV- and MC-ADDs by plotting the RD of
%  mean D  within IN and OUT volumes against the mean CT number within the same volumes.


%% Choose files to compare

%  Choose a VOI: IN or OUT
VOI_name = 'IN';

%  Choose a treatment stage: Planning or Verification
TreatmentStage = 'Planning';

%% For each patient

for patient = 1:6

    % Loads VSV- and MC-ADDs
    VSV  = load_untouch_nii(strcat('Patients\', int2str(patient), '\VSV\', TreatmentStage,'-ADD.nii'));
    MC   = load_untouch_nii(strcat('Patients\', int2str(patient), '\MC\', TreatmentStage,'-ADD.nii'));

    % Loads CT image
    CT  = load_untouch_nii(strcat('Patients\', int2str(patient), '\CTs\', TreatmentStage,'-CT.nii'));

    % Loads VOI
    VOI    = load_untouch_nii(strcat('Patients\', int2str(patient), '\VOIs\', VOI_name, '.nii'));

    % Selects voxels within the VOI
    VSV_ADD_array         = VSV.img(:);
    MC_ADD_array          = MC.img(:);
    CT_array              = CT.img(:);
    VSV_ADD_VOI           = VSV_ADD_array(VOI.img(:)~=0);
    MC_ADD_VOI            = MC_ADD_array(VOI.img(:)~=0);
    CT_VOI                = CT_array(VOI.img(:)~=0);

    % Computes mean D within the VOI
    meanDose(patient,:)   = [mean(VSV_ADD_VOI(:)) mean(MC_ADD_VOI(:))];

    % Computes mean HU and std HU within the VOI
    meanHU(patient)       = mean(single(CT_VOI));
    stdHU(patient)        = std(single(CT_VOI));

end


%% RD of mean D
RD_meanDose        = (meanDose(:,1) - meanDose(:,2)) ./ meanDose(:,2);
median_RD_meanDose = median(RD_meanDose);
IQR_RD_meanDose    = iqr(RD_meanDose);

%% RD-Heterogeneity plots
scatter(RD_meanDose, meanHU);
