%% PATIENT-SPECIFIC 1D PROFILES AT THE LIVER INTERFACE WITH SURROUNDING TISSUES
%
%  Plot D_k in matching k voxels in VSV- and MC-ADDs and the CT number for 
%  the same voxel k in a selected 1D profile crossing relevant interface 
%  regions, including PTV, NLV, and lungs volume. 

%% Choose files to compare

%  Choose a treatment stage: Planning or Verification
TreatmentStage = 'Planning';

%  Choose a patient 
patient = 1;

%% Loads data 

% Loads VSV- and MC-ADDs
VSV  = load_untouch_nii(strcat('Patients\', int2str(patient), '\VSV\', TreatmentStage,'-ADD.nii'));
MC   = load_untouch_nii(strcat('Patients\', int2str(patient), '\MC\', TreatmentStage,'-ADD.nii'));
    
% Loads CT image
CT  = load_untouch_nii(strcat('Patients\', int2str(patient), '\CTs\', TreatmentStage,'-CT.nii'));
    
% Loads profile volume
VOI    = load_untouch_nii(strcat('Patients\', int2str(patient), '\VOIs\Profile.nii'));

%% Selects voxels within the VOI

VSV_ADD_array         = VSV.img(:);
MC_ADD_array          = MC.img(:);
CT_array              = CT.img(:);
VSV_ADD_VOI           = VSV_ADD_array(VOI.img(:)~=0);
MC_ADD_VOI            = MC_ADD_array(VOI.img(:)~=0);
CT_VOI                = CT_array(VOI.img(:)~=0);

%% Plots profile

figure(1)
plot(VSV_ADD_VOI);
hold on 
plot(MC_ADD_VOI);
hold on 
plot(CT_VOI);
