function ADD = dosimetryCalibrationVSV(VSVkernel, IAD)
%DOSIMETRYCALIBRATIONVSV computes a personalized absorbed dose distribution
%  by convoluting a VSV kernel for Y90 and the patient's integrated activity 
%  distribution
%  
%  Input:
%       VSVkernel - [11x11x11 double] voxel S-values kernel for Y90 in soft 
%                   tissues, in mGy /(MBq s) 
%       IAD       - [loaded image in NIfTI format] integrated activity 
%                   distribution, in MBq s
%  Returns:
%       ADD       - [loaded image in NIfTI format] absorbed dose distribution, in Gy
% 
%  --------------------------- EXAMPLE --------------------------------
%  Example: 
%       VSVkernel = load('VSV.mat');
%       IAD       = load_untouch_nii('PatientXXX_IAD.nii');
%       ADD       = dosimetryCalibrationVSV(VSVkernel, IAD);
%       save_untouch_nii(ADD, 'PatientXXX_ADD_VSVdosimetry');

 
ADD = IAD; 
ADD.img = convn(IAD.img, VSVkernel * 10^-3, 'same') ; 

end