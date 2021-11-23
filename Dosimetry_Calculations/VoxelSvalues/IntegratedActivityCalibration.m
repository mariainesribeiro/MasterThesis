function IAD = IntegratedActivityCalibration(AA, LSF, R, PET, RWLV)
% INTEGRATEDACTIVITYCALIBARTION computes a personalized integrated activity
%  distribution based on a patient's SPECT or PET image and scaled to the
%  patient's administrated activity of Y90 within the reference whole liver
%  volume, estimated lung shut fraction, and measured vial residue.
%
%  Input:
%       AA      - [double] administrated activity of Y90, in MBq
%       LSF     - [double] lung shunt fraction, in %
%       R       - [double] vial residue, in %
%       PET     - [loaded 3D image in NIfTI format] PET or SPECT image
%       RWLV    - [loaded 3D image in NIfTI format] segmentation image of 
%                 reference whole liver volume           
%  Returns:
%       IAD     - [loaded 3D image in NIfTI format] integrated activity 
%                 distribution in NIfTI format, in MBq s
% 
%  --------------------------- EXAMPLE ------------------------------
%
%       AA      = 3000; 
%       LSF     = 10;
%       R       = 3;
%       PET     = load_untouch_nii('PatientXXX_PET.nii');
%       RWLV    = load_untouch_nii('PatientXXX_RWLV.nii');
%       IAD     = IntegratedActivityCalibration(AA, LSF, R, PET, RWLV)
%       save_untouch_nii(IAD, 'PatientXXX_IAD');

%% Calibrates PET or SPECT image to activity distribution

% Sums PET or SPECT counts within RWLV
PET_RWLV = PET.img(RWLV.img ~= 0);
counts_RWLV = sum(PET_RWLV(:));

%Calibration step, from raw count to MBq
AD = PET.img .* AA .* (1-R/100) .* (1-LSF/100) ./ counts_RWLV;  

%% Calibrates activity distribution to integrated activity distribution

t0       = 0;   % Y90 administration time
t1       = Inf; % permanent entrapment of Y90 in tissues
halfLife = 2.7 * 24 * 60 * 60; % Y90 half-life in seconds
lambda   = calculateIntegral(halfLife,t0,t1); 

% Calibration step, from MBq to MBq s
IAD = PET;  %initiates a loaded NIfTI image equivalent to PET 
IAD.img  = AD .* lambda; % stores integrated activity in MBq s

end