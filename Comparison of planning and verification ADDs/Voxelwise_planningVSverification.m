
%% VOXELWISE COMPARISON OF PLANNING AND VERIFICATION ABSORBED DOSE DISTRIBUTIONS (ADDs)
%  Assesses the voxelwise agreement and correlation between all patiens' pairs 
%  of planning and verification ADDs obtained with each dosimetry method
%  through the voxelwise ICC, PCC, and gamma-index test within the NLV and
%  PTV

%% Choose files to compare

%  Choose a VOI: NLV or PTV
VOI_name = 'NLV';

%  Choose a DosimetryMethod: VSV or MC
DosimetryMethod = 'VSV';

%% For each patient 
for i = 1:6
    
    % Loads planning and verification ADDs
    planningADD     = load_untouch_nii(strcat('Patients\', int2str(i), '\',DosimetryMethod,'\Planning-ADD.nii'));
    verificationADD = load_untouch_nii(strcat('Patients\', int2str(i), '\',DosimetryMethod,'\Verification-ADD.nii'));

    % Loads VOI 
    VOI    = load_untouch_nii(strcat('Patients\', int2str(patient), '\VOIs\', VOI_name, '.nii'));

    % Selects voxels within the VOI
    planningADD_array         = planningADD.img(:);
    verificationADD_array     = verificationADD.img(:);
    planningADD_VOI           = planningADD_array(VOI.img(:)~=0);
    verificationADD_VOI       = verificationADD_array(VOI.img(:)~=0);
    data_VOI                  = [planningADD_VOI verificationADD_VOI];

    % Computes ICC 
    icc(i)  =  ICC(data_VOI,'A-1',0.05,0);

    % Computes PCC
    pcc(i)  = corrcoef(data_VOI);

    % Computes the passing rate of the gamma-index test
    DD = 10;  % dose difference, in %
    DTA = 10; % distance to agreement, in mm
    gamma_PR(i) = gammaIndexTest(planningADD, verificationADD, VOI, DD, DTA);
    
end

%% OVERALL

median_icc      = median(icc);
median_pcc      = median(pcc);
median_gamma_PR = median(gamma_PR);