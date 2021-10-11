function VSVkernel = VSVkernelCalibration(DoseKernel,N)
%VSVKERNELCALIBRATION calibrates GATE's output dose kernel to a VSV kernel
% 
%   Input:
%      DoseKernel - [loaded image in MHD format] GATE's output dose kernel,
%                       in Gy
%      N          - [double] simulated primary particles, in million
%   
%   Returns:
%      VSVkernel  - [11x11x11 double] VSV kernel, in mGy/(MBq s)
%
%   ------------------------------ EXAMPLE ----------------------------
%
% DoseKernel = read_mhd('Kernel-Dose.mhd');
% N          = 100;
% VSVkernel  = VSVkernelCalibration(DoseKernel, N);
%

DoseKernel_mGy = DoseKernel.data .* 1000;
VSVkernel = DoseKernel_mGy ./N;
end

