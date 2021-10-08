# Quantification of tissue heterogeinty within the NLV and PTV

This folder includes de code developed to quantify tissue heterogeneity within the NLV and PTV according to a patient-specific CT image and the obtained HU calibration.

**Files**

1. *calibration.mat*
  - describes the HU-mass density poly-line, including the slope and y-intercept for every line connecting two consecutive representative tissues.

2. *QuantificationTissueHeterogeneity.m* 
  - calibrates each voxel in a CT image to mass density, reporting the distribution of mass density within each VOI
  - assigns each voxel in a CT image to a chemical composition bin, reporting the percentage of voxels within each VOI assgined to each bin.
