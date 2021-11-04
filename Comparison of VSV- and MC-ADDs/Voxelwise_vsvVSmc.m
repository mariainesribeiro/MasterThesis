%% VOXELWISE COMPARISON OF VSV- AND MC-ADDs
%  Assesses the voxelwise agreement and correlation between all patiens'
%  pairs of VSV- and MC-ADDs through the voxelwise ICC and PCC within the 
%  NLV and PTV 

%% Choose files to compare

%  Choose a VOI: NLV or PTV
VOI_name = 'NLV';

%  Choose a treatment stage: Planning or Verification
TreatmentStage = 'Planning';

%% For each patient (1 to 6)
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
    data_VOI              = [VSV_ADD_VOI'; MC_ADD_VOI']';

    % Computes ICC 
    icc(patient)  =  ICC(data_VOI,'A-1',0.05,0);

    % Computes PCC
    pcc_           = corrcoef(data_VOI);
    pcc(patient)  = pcc_(2,1);
    
    % Plots BAP
    RD_vsvVSmc   = (VSV_ADD_VOI - MC_ADD_VOI) ./ MC_ADD_VOI;
    Mean_vsvVSmc = (VSV_ADD_VOI + MC_ADD_VOI) ./ 2;
    figure(patient)
    scatter(Mean_vsvVSmc, RD_vsvVSmc);
    hold on
    yline(median(RD_vsvVSmc));
    % ALTERNATIVELY -------------------
    % hold on
    % yline(mean(RD_vsvVSmc));
    % hold on
    % yline(std(RD_vsvVSmc)*1.96 + mean(RD_vsvVSmc));
    % hold on
    % yline(std(RD_vsvVSmc)*1.96 - mean(RD_vsvVSmc));
    
end

%% OVERALL

median_icc      = median(icc);
median_pcc      = median(pcc);