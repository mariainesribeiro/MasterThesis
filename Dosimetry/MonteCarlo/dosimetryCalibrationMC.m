function ADD = dosimetryCalibrationMC(GATEoutput, N, AA, LSF, R, PET, RWLV)
% DOSECALIBRATIONMC calibrates a personalized GATE's output absorbed dose 
%   distribution according to Y90 radioactive decay over time and patient's
%   administrated activity of Y90 within the reference whole liver volume, 
%   measured vial redidue and estimated lung shunt fraction.
% 
%   Input:
%       GATEoutput - [loaded image in NIfTI format] GATE's output 
%                       uncalibrated absorbed dose distribution, in Gy
%       N          - [double] simulated primary particles, in millions
%       AA         - [double] administrated activity, in MBq
%       LSF        - [double] lung shunt fraction, in %
%       R          - [double] vial residue, in %
%       PET        - [loaded 3D image in NIfTI format] PET or SPECT image
%       RWLV       - [loaded 3D image in NIfTI format] segmentation image 
%                      of reference whole liver volume   
%   Returns:
%       ADD        - [loaded image in NIfTI format] 3D calibrated absorbed 
%                      dose distribution, in Gy
%
%   ----------------------------- EXAMPLE  ----------------------------
%       GATEoutput = load_untouch_nii('PatientXXX_GATEoutput_100M_PP.nii');
%       N          = 100;
%       AA         = 3000; 
%       LSF        = 10;
%       R          = 3;
%       PET        = load_untouch_nii('PatientXXX_PET.nii');
%       RWLV       = load_untouch_nii('PatientXXX_RWLV.nii');
%       ADD        = dosimetryCalibrationMC(GATEoutput, N, AA, LSF, R, PET,
%                    RWLV);
%       save_untouch_nii(ADD, 'PatientXXX_ADD_MCdosimetry');

%% Computes the calibration factor 

%integrated activity factor
t0 = 0;   % Y90 administration time
t1 = Inf; % permanent entrapment of Y90 in tissues
halfLife = 2.7 * 24 * 60 * 60; % Y90 half-life in seconds
lambda = calculateIntegral(halfLife,t0,t1); 

%total counts in PET image
counts_box = sum(PET.img(:)); 

%pet counts within RWLV
PET_RWLV = PET.img(RWLV.img ~= 0);
counts_RWLV = sum(PET_RWLV(:));

%calibration factor
calbFactor = counts_box / counts_RWLV * AA * (1-LSF/100) * (1 - R/100) * lambda / N; 

%% Calibrates MC-GATE simulation output to 3D absorbed dose distribution and saves it in a NIfTI format

ADD = PET;
ADD.img = GATEoutput.img * calbFactor; 

end

