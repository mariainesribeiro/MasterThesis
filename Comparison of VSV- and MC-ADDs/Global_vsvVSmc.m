%% GLOBAL AGREEMENT BETWEEN VSV- AND MC-ADDs
%  Assesses the global agreement and correlation between all patiens' pairs
%  of VSV- and MC-ADDs within the NLV and PTV through cDVHs and dDVHs.
%  The bin width of DVHs was set to 1 Gy.
%  Computes the maximum difference, ICC and PCC between equivalent DVHs.

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

    % Computes DVHs
    Y_volume_VSV_d = DVHdifferential(VSV,VOI);
    Y_volume_VSV_c = DVHcumulative(VSV,VOI);
    Y_volume_MC_d  = DVHdifferential(MC,VOI);
    Y_volume_MC_c  = DVHcumulative(MC,VOI);

    % Computes ICC
    icc_d(patient) = ICC([Y_volume_VSV_d Y_volume_MC_d],'A-1',0.05,0);
    icc_c(patient) = ICC([Y_volume_VSV_c Y_volume_MC_c],'A-1',0.05,0);

    % Computes PCC
    pcc_d(patient) = corrcoef([Y_volume_VSV_d Y_volume_MC_d]);
    pcc_c(patient) = corrcoef([Y_volume_VSV_c Y_volume_MC_c]);

    % Computes maximum deviation
    max_deviation_d(patient) = max(Y_volume_VSV_d - Y_volume_MC_d);
    max_deviation_c(patient) = max(Y_volume_VSV_c - Y_volume_MC_c);

end

%% Globally

median_icc_d        = median(icc_d);
median_icc_c        = median(icc_c);
median_pcc_d        = median(pcc_d);
median_pcc_c        = median(pcc_c);
abs_max_deviation_d = max(max_deviation_d);
abs_max_deviation_c = max(max_deviation_c);
