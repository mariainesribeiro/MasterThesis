
%% GLOBAL AGREEMENT AND CORRELATIO BETWEEN PLANNING AND VERIFICATION ADD
%  Assesses the global agreement and correlation between all patients's 
%  pairs of planning and verification ADDs obtained with each dosimetry 
%  method through the ICC and PCC of the mean D computed and within  NLV 
%  and PTV.
%  Plots the mean D within a VOI in planning ADDs against that in verification ADDs.

%% Choose files to compare

%  Choose a VOI: NLV or PTV
VOI_name = 'NLV';

%  Choose a DosimetryMethod: VSV or MC
DosimetryMethod = 'VSV';

%% For each patient 

for patient = 1:6
    
    % Loads planning and verification ADDs
    planningADD     = load_untouch_nii(strcat('Patients\', int2str(patient), '\',DosimetryMethod,'\Planning-ADD.nii'));
    verificationADD = load_untouch_nii(strcat('Patients\', int2str(patient), '\',DosimetryMethod,'\Verification-ADD.nii'));

    % Loads VOI 
    VOI    = load_untouch_nii(strcat('Patients\', int2str(patient), '\VOIs\', VOI_name, '.nii'));

    % Selects voxels within the VOI
    planningADD_array         = planningADD.img(:);
    verificationADD_array     = verificationADD.img(:);
    planningADD_VOI           = planningADD_array(VOI.img(:)~=0);
    verificationADD_VOI       = verificationADD_array(VOI.img(:)~=0);
    
    % Computed the mean D within the VOI
    meanDose_VOI(patient,:)         = [mean(planningADD_VOI(:)) mean(verificationADD_VOI(:))];

end

%% Globally

% Computes 	ICC
icc = ICC(meanDose_VOI,'A-1',0.05,0);

% Computes PCC
pcc = corrcoef(meanDose_VOI);

% Plots mean D within a VOI in planning ADDs against that in verification ADDs
scatter(meanDose_VOI(:,1), meanDose_VOI(:,2));


