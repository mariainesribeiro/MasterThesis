%% QUANTIFICATION OF TISSUE HETEROGENEITY WITHIN THE NLV AND PTV

%% Load CT image in NIfTI format
CT = load_untouch_nii('CT_SPECT_2p21.nii');
CT = CT.img;
CT_array = CT(:);

%% Load segmentation images in NIfTI format

PTV = load_untouch_nii('ptv_2p21_crop.nii');
PTV_array = CT_array(PTV.img(:)~=0);
NLV = load_untouch_nii('nlv_2p21_crop.nii');
NLV_array = CT_array(NLV.img(:)~=0);

%% Calibrate each voxel in the CT image to mass density

load('calibration.mat')
% Within the NLV
NLV_array_rho = double(NLV_array);
for i = 1:length(NLV_array_rho)
    % Air - Lung
    if NLV_array_rho(i) < -620
        NLV_array_rho(i) = NLV_array_rho(i) * cal(1,1) + cal(1,2);
    % Extra Lung - Lung
    elseif NLV_array_rho(i) >= -620 && NLV_array_rho(i) < -205
        NLV_array_rho(i) = NLV_array_rho(i) * cal(2,1) + cal(2,2);
    % Extra Lung - Fat
    elseif NLV_array_rho(i) >= -205 && NLV_array_rho(i) < -122
        NLV_array_rho(i) = NLV_array_rho(i) * cal(3,1) + cal(3,2);
    % Fat - Adipose/Marrow
    elseif NLV_array_rho(i) >= -122 && NLV_array_rho(i) < -70
        NLV_array_rho(i) = NLV_array_rho(i) * cal(4,1) + cal(4,2);
    % Adipose/Marrow - Muscle/General
    elseif NLV_array(i) >= -70 && NLV_array_rho(i) < 42
        NLV_array_rho(i) = NLV_array_rho(i) * cal(5,1) + cal(5,2);
    % Muscle/General - Miscellaneous
    elseif NLV_array_rho(i) >= 42 && NLV_array_rho(i) < 81
        NLV_array_rho(i) = NLV_array_rho(i) * cal(6,1) + cal(6,2);
    % Miscellaneous - Heavy spongiosa
    elseif NLV_array_rho(i) >= 81 && NLV_array_rho(i) < 207
        NLV_array_rho(i) = NLV_array_rho(i) * cal(7,1) + cal(7,2);
    % Heavy spongiosa - Mineral bone
    elseif NLV_array_rho(i) >= 207 && NLV_array_rho(i) < 1603
        NLV_array_rho(i) = NLV_array_rho(i) * cal(8,1) + cal(8,2);
    % Mineral bone - Tooth
    elseif NLV_array_rho(i) >= 1603 && NLV_array_rho(i) < 3130
        NLV_array_rho(i) = NLV_array_rho(i) * cal(9,1) + cal(9,2);
    % Tooth - Hydroxyapatite
    else
        NLV_array_rho(i) = NLV_array_rho(i) * cal(10,1) + cal(10,2);
    end
end

% Within the PTV
PTV_array_rho = double(PTV_array);
for i = 1:length(PTV_array_rho)
    % Air - Lung
    if PTV_array_rho(i) < -620
        PTV_array_rho(i) = PTV_array_rho(i) * cal(1,1) + cal(1,2);
    % Extra Lung - Lung
    elseif PTV_array_rho(i) >= -620 && PTV_array_rho(i) < -205
        PTV_array_rho(i) = PTV_array_rho(i) * cal(2,1) + cal(2,2);
    % Extra Lung - Fat
    elseif PTV_array_rho(i) >= -205 && PTV_array_rho(i) < -122
        PTV_array_rho(i) = PTV_array_rho(i) * cal(3,1) + cal(3,2);
    % Fat - Adipose/Marrow
    elseif PTV_array_rho(i) >= -122 && PTV_array_rho(i) < -70
        PTV_array_rho(i) = PTV_array_rho(i) * cal(4,1) + cal(4,2);
    % Adipose/Marrow - Muscle/General
    elseif NLV_array(i) >= -70 && PTV_array_rho(i) < 42
        PTV_array_rho(i) = PTV_array_rho(i) * cal(5,1) + cal(5,2);
    % Muscle/General - Miscellaneous
    elseif PTV_array_rho(i) >= 42 && PTV_array_rho(i) < 81
        PTV_array_rho(i) = PTV_array_rho(i) * cal(6,1) + cal(6,2);
    % Miscellaneous - Heavy spongiosa
    elseif PTV_array_rho(i) >= 81 && PTV_array_rho(i) < 207
        PTV_array_rho(i) = PTV_array_rho(i) * cal(7,1) + cal(7,2);
    % Heavy spongiosa - Mineral bone
    elseif PTV_array_rho(i) >= 207 && PTV_array_rho(i) < 1603
        PTV_array_rho(i) = PTV_array_rho(i) * cal(8,1) + cal(8,2);
    % Mineral bone - Tooth
    elseif PTV_array_rho(i) >= 1603 && PTV_array_rho(i) < 3130
        PTV_array_rho(i) = PTV_array_rho(i) * cal(9,1) + cal(9,2);
    % Tooth - Hydroxyapatite
    else
        PTV_array_rho(i) = PTV_array_rho(i) * cal(10,1) + cal(10,2);
    end
end

%% Plot a box plot of the distribution of mass density within each VOI

% Within the NLV
figure(1)
boxplot(NLV_array_rho)
% Within the PTV
figure(2)
boxplot(PTV_array_rho)

% Mean mass density within each VOI
mean_rho_NLV = mean(NLV_array_rho);
mean_rho_PTV = mean(PTV_array_rho);

%% Count the voxels assigned to each chemical composition bin

% Within the NLV
counts_NLV = zeros(19,1);
for i = 1:length(NLV_array)
    % 1. Air
    if NLV_array(i) < -900
        counts_NLV(1) = counts_NLV(1) + 1;
    % 2. Lung
    elseif NLV_array(i) >= -900 && NLV_array(i) < -411
        counts_NLV(2) = counts_NLV(2) + 1;
    % 3. Extra lung
    elseif NLV_array(i) >= -411 && NLV_array(i) < -162
        counts_NLV(3) = counts_NLV(3) + 1;
    % 4. Fat
    elseif NLV_array(i) >= -161 && NLV_array(i) < -95
        counts_NLV(4) = counts_NLV(4) + 1;
    % 5. Adipose/Marrow
    elseif NLV_array(i) >= -95 && NLV_array(i) < -13
        counts_NLV(5) = counts_NLV(5) + 1;
    % 6. Muscle/General
    elseif NLV_array(i) >= -13 && NLV_array(i) < 63
        counts_NLV(6) = counts_NLV(6) + 1;
    % 7. Miscellaneous
    elseif NLV_array(i) >= 63 && NLV_array(i) < 145
        counts_NLV(7) = counts_NLV(7) + 1;
    % 8. Heavy spongiosa
    elseif NLV_array(i) >= 145 && NLV_array(i) < 285
        counts_NLV(8) = counts_NLV(8) + 1;
    % 9. HS - MB 1
    elseif NLV_array(i) >= 285 && NLV_array(i) < 441
        counts_NLV(9) = counts_NLV(9) + 1;
    % 10. HS - MB 2
    elseif NLV_array(i) >= 441 && NLV_array(i) < 596
        counts_NLV(10) = counts_NLV(10) + 1;
    % 11. HS - MB 3
    elseif NLV_array(i) >= 596 && NLV_array(i) < 751
        counts_NLV(11) = counts_NLV(11) + 1;
    % 12. HS - MB 4
    elseif NLV_array(i) >= 751 && NLV_array(i) < 906
        counts_NLV(12) = counts_NLV(12) + 1;
    % 13. HS - MB 5
    elseif NLV_array(i) >= 906 && NLV_array(i) < 1061
        counts_NLV(13) = counts_NLV(13) + 1;
    % 14. HS - MB 6
    elseif NLV_array(i) >= 1061 && NLV_array(i) < 1217
        counts_NLV(14) = counts_NLV(14) + 1;
    % 15. HS - MB 7
    elseif NLV_array(i) >= 1217 && NLV_array(i) < 1372
        counts_NLV(15) = counts_NLV(15) + 1;
    % 16. HS - MB 8
    elseif NLV_array(i) >= 1372 && NLV_array(i) < 1527
        counts_NLV(16) = counts_NLV(16) + 1;
    % 17. Mineral bone
    elseif NLV_array(i) >= 1527 && NLV_array(i) < 2368
        counts_NLV(17) = counts_NLV(17) + 1;
    % 18. Tooth
    elseif NLV_array(i) >= 2368 && NLV_array(i) < 3759
        counts_NLV(18) = counts_NLV(18) + 1;
    % 19. Hydroxyapatite
    elseif NLV_array(i) > 3759
        counts_NLV(19) = counts_NLV(19) + 1;
    end
end
percentage_NLV = counts_NLV/length(NLV_array)*100;

% Within the PTV
counts_PTV = zeros(19,1);
for i = 1:length(PTV_array)
    % 1. Air
    if PTV_array(i) < -900
        counts_PTV(1) = counts_PTV(1) + 1;
    % 2. Lung
    elseif PTV_array(i) >= -900 && PTV_array(i) < -411
        counts_PTV(2) = counts_PTV(2) + 1;
    % 3. Extra lung
    elseif PTV_array(i) >= -411 && PTV_array(i) < -162
        counts_PTV(3) = counts_PTV(3) + 1;
    % 4. Fat
    elseif PTV_array(i) >= -161 && PTV_array(i) < -95
        counts_PTV(4) = counts_PTV(4) + 1;
    % 5. Adipose/Marrow
    elseif PTV_array(i) >= -95 && PTV_array(i) < -13
        counts_PTV(5) = counts_PTV(5) + 1;
    % 6. Muscle/General
    elseif PTV_array(i) >= -13 && PTV_array(i) < 63
        counts_PTV(6) = counts_PTV(6) + 1;
    % 7. Miscellaneous
    elseif PTV_array(i) >= 63 && PTV_array(i) < 145
        counts_PTV(7) = counts_PTV(7) + 1;
    % 8. Heavy spongiosa
    elseif PTV_array(i) >= 145 && PTV_array(i) < 285
        counts_PTV(8) = counts_PTV(8) + 1;
    % 9. HS - MB 1
    elseif PTV_array(i) >= 285 && PTV_array(i) < 441
        counts_PTV(9) = counts_PTV(9) + 1;
    % 10. HS - MB 2
    elseif PTV_array(i) >= 441 && PTV_array(i) < 596
        counts_PTV(10) = counts_PTV(10) + 1;
    % 11. HS - MB 3
    elseif PTV_array(i) >= 596 && PTV_array(i) < 751
        counts_PTV(11) = counts_PTV(11) + 1;
    % 12. HS - MB 4
    elseif PTV_array(i) >= 751 && PTV_array(i) < 906
        counts_PTV(12) = counts_PTV(12) + 1;
    % 13. HS - MB 5
    elseif PTV_array(i) >= 906 && PTV_array(i) < 1061
        counts_PTV(13) = counts_PTV(13) + 1;
    % 14. HS - MB 6
    elseif PTV_array(i) >= 1061 && PTV_array(i) < 1217
        counts_PTV(14) = counts_PTV(14) + 1;
    % 15. HS - MB 7
    elseif PTV_array(i) >= 1217 && PTV_array(i) < 1372
        counts_PTV(15) = counts_PTV(15) + 1;
    % 16. HS - MB 8
    elseif PTV_array(i) >= 1372 && PTV_array(i) < 1527
        counts_PTV(16) = counts_PTV(16) + 1;
    % 17. Mineral bone
    elseif PTV_array(i) >= 1527 && PTV_array(i) < 2368
        counts_PTV(17) = counts_PTV(17) + 1;
    % 18. Tooth
    elseif PTV_array(i) >= 2368 && PTV_array(i) < 3759
        counts_PTV(18) = counts_PTV(18) + 1;
    % 19. Hydroxyapatite
    elseif NLV_array(i) > 3759
        counts_PTV(19) = counts_PTV(19) + 1;
    end
end
percentage_PTV = counts_PTV/length(PTV_array)*100;
