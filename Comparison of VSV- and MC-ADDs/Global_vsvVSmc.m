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
    [Y_volume_VSV_d, max_d_VSV] = DVHdifferential(VSV,VOI);
    Y_volume_VSV_c = DVHcumulative(VSV,VOI);
    [Y_volume_MC_d, max_d_MC]  = DVHdifferential(MC,VOI);
    Y_volume_MC_c  = DVHcumulative(MC,VOI);
    if max_d_VSV > max_d_MC
      Y_volume_MC_d(ceil(max_d_VSV)) = 0;
      Y_volume_MC_c(ceil(max_d_VSV)) = 0;
    else
      Y_volume_VSV_d(ceil(max_d_VSV)) = 0;
      Y_volume_VSV_c(ceil(max_d_VSV)) = 0;  
    end
    
    % Computes ICC
    icc_d(patient) = ICC([Y_volume_VSV_d; Y_volume_MC_d]','A-1',0.05,0);
    icc_c(patient) = ICC([Y_volume_VSV_c; Y_volume_MC_c]','A-1',0.05,0);

    % Computes PCC
    pcc = corrcoef([Y_volume_VSV_d; Y_volume_MC_d]');
    pcc_d(patient)  = pcc(2,1);
    pcc = corrcoef([Y_volume_VSV_c; Y_volume_MC_c]');
    pcc_c(patient) = pcc(2,1);
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
