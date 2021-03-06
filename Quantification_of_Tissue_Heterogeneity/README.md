# Quantification of tissue heterogeinty within the NLV and PTV
The key difference between MC and VSV dosimetry is that the former considers tissue heterogeneity, while the latter neglects it.
Thus, the level of tissue heterogeneity predicts the variation between MC- and VSV-ADDs. As ADDs are the most relevant within the NLV and PTV to RE optimization, tissue heterogeneity was investigated within these VOIs.

**The code developed in this folder aims to:**
   - Quantify tissue heterogeneity within the NLV and PTV according to the obtained HU calibration and patient-specific CT image.

*Read Section 4.3 in the thesis manuscript for more detailed information.*

## Folders and files
1. *calibration.mat*:
   - Describes the poly-line calibration of HU to mass density, including the slope and y-intercept for every line connecting two consecutive representative tissues.

2. *QuantificationTissueHeterogeneity.m* <-- main file
   - Calibrates each voxel in a CT image to mass density, reporting the distribution of mass density within each VOI
   - Assigns each voxel in a CT image to a chemical composition bin, reporting the percentage of voxels within each VOI assgined to each bin.
