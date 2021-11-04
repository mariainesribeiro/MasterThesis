function [Y_volume, max_D] = DVHcumulative(ADD,VOI)
%DVHCUMULATIVE computes the volume axis of the cumulative DVH
%
%   Input:
%       ADD  - [image in NIfTI format] ADD, in Gy
%       VOI  - [image in NIfTI format] segmented VOI
%
%   Returns:
%       Y_volume - [1 x max_D+1 double] volume axis of the cumulative DVH
%       max_D    - [integer] integer maximum absorbed dose within the VOI in the ADDs
%
%  ---------------------------- EXAMPLE -------------------------------------
%  ADD = load_untouch_nii('PatientXXX_ADD.nii');
%  VOI = load_untouch_nii('PatientXXX_VOI.nii');
%  [Y_volume, max_D] = DVHcumulative(ADD,VOI);
%  X_dose = 0:max_D;
%  plot(X_dose, Y_volume);
%

%% Selects voxels within the VOI
ADD_array = ADD.img(:);
VOI_array = VOI.img(:);
VOI_ADD_array = ADD_array(VOI_array(:)~=0)

%% Computes the Y-volume axis of cumulative DVH
max_D = max(VOI_ADD_array);
VOI_vox = length(VOI_ADD_array);
Y_volume = 0:max_D;
for d = 0:max_D
    Y_volume(d+1) = sum(VOI_ADD_array > d | VOI_ADD_array == d )/VOI_vox;
end

end
