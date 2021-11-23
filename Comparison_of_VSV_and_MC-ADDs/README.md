# Comparison of VSV- and MC-ADDs
The main goals of the thesis are to (1) assess the accuracy of VSV dosimetry compared to the gold standard MC dosimetry and (2) evaluate the relevance and feasibility of introducing MC dosimetry in clinical practice to optimize RE and boost patient's OS.

**The code developed in this folder aims to:**
  - Test the agreement and correlation between 12 pairs of VSV- and MC-ADDs,  
  indicating the accuracy of VSV dosimetry compared to the gold standard MC
  dosimetry and the relevance of introducing MC dosimetry in the clinical practice.

Special attention was given to the relevant VOIs in RE optimization, i.e., the NLV and PTV, and to the liver interface with surrounding tissues.
MC-ADDs were considered the reference ADDs because MC dosimetry is the gold standard method for RE dosimetry. No considerations were made to differ treatment planning and verification ADDs.

*Read Section 4.5 in the thesis manuscript for more detailed information.*

## Folders and files

1. *DVHcumulative.m*:
   - Computes the volume axis of the cumulative DVH.
2. *DVHdifferential.m*:
   - Computes the volume axis of the differential DVH.
3. *Global_vsvVSmc.m*:
   - Assesses the global agreement and correlation between all patiens' pairs
   of VSV- and MC-ADDs within the NLV and PTV through cDVHs and dDVHs.
   The bin width of DVHs was set to 1 Gy.
   - Computes the maximum difference, ICC and PCC between equivalent DVHs.
4. *Interface_vsvVSmv.m*:  
   - Assesses the agreement between VSV- and MC-ADDs  through the RD of mean D within
   the IN and OUT volumes.
   - Assesses the correlation between VSV- and MC-ADDs by plotting the RD of
    mean D  within IN and OUT volumes against the mean CT number within the same volumes.
5. *Interface_Profile.m*:
   - Plots D_k in matching k voxels in VSV- and MC-ADDs and the CT number for
   the same voxel k in a selected 1D profile crossing relevant interface
   regions, including PTV, NLV, and lungs volume.
6. *MeanD_EUBED_vsvVSmc.m*:
   - Assesses the agreement and correlation of mean D and EUBED  within the
   NLV and PTV computed for all patiens' pairs of VSV- and MC- ADDs
   through BAPs, RD, absolute RD, ICC, and PCC.
7. *Voxelwise_vsvVSmc.m*:
   - Assesses the voxelwise agreement and correlation between all patiens'
   pairs of VSV- and MC-ADDs through the voxelwise ICC and PCC within the
   NLV and PTV.
