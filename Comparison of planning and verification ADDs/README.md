# Comparison of planning and verification ADDs
Planning and verification ADDs were compared in this thesis to assess variations in treatment planning quality between VSV and MC-GATE dosimetry methods.

**The code developed in this folder aims to:**
  - Test the agreement and correlation between planning and verification ADDs;
  - Test treatment planning quality of each dosimetry method.


*Read Section 4.6 in the thesis manuscript for more detailed information.*

## Folders and files

1. *Global_planningVSverification.m*:
   - Assesses the global agreement and correlation between all patients's
     pairs of planning and verification ADDs obtained with each dosimetry
     method through the ICC and PCC of the mean D computed and within  NLV
     and PTV.
   - Plots the mean D within a VOI in planning ADDs against that in verification ADDs.
2. *Voxelwise_planningVSverification.m*: A
   - Assesses the voxelwise agreement and correlation between all patiens' pairs
     of planning and verification ADDs obtained with each dosimetry method
     through the voxelwise ICC, PCC, and gamma-index test within the NLV and
     PTV
