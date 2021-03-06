# Dosimetry Calculations

In radioembolization, the activity of Y90 to be administrated to a patient
should be optimized through personalized dosimetry.

**The code developed in this folder aims to:**
   - Compute personalized absorbed dose distributions following two DOSIMETRY
methods: voxel S-values and Monte Carlo (gold standard).

*Read Section 4.4 in the thesis manuscript for more detailed information.*

## Folders and files

1. **MonteCarlo**
   1. *calculateIntegral.m*:
   - Calculates the integral of a radioactive decay
   given a half-time constant.
   2. *dosimetryCalibration.m*:
   - Calibrates a personalized GATE's output absorbed dose
   distribution according to Y90 radioactive decay over time and patient's
   administrated activity of Y90 within the reference whole liver volume,
   measured vial redidue and estimated lung shunt fraction.
   - STEP 2 of MC dosimetry in the thesis manuscript.
   3. *GATEscript_MCdosimetry.mac*:
   - Full GATE's script to simulate the dose kernel
   for a central source voxel of Y90 emitting isotropically in a soft tissue medium,
   and scored in a 3D grid of 11x11x11 cubic voxels with a resolution of 2.21x2.21x2.21 mm^3.
   - STEP 1 of MC dosimetry in the thesis manuscript.

2. **VoxelSvalues**
   1. *calculateIntegral.m*:
   - The same as before.
   2. *dosimetryCalibrationVSV.m*:
   - Computes a personalized absorbed dose distribution by convoluting a VSV kernel for Y90 and the patient's integrated activity.
   - STEP 4 of VSV dosimetry in the thesis manuscript
   3. *GATEscript_VSVdosimetry.mac*:
   - Full GATE's script to simulate uncalibrated absorbed dose distributions scored in a 3D grid with a resolution of  2.21x2.21x2.21 mm^3, according to a patient's' planning SPECT/CT or verification PET/CT images.
   - STEP 1 of VSV dosimetry in the thesis manuscript.
   4. *IntegratedActivityCalibration.m*:
   - Computes a personalized integrated activity
   distribution based on a patient's SPECT or PET image and scaled to the
   patient's administrated activity of Y90 within the reference whole liver
   volume, estimated lung shut fraction, and measured vial residue.
   - STEP 3 of VSV dosimetry in the thesis manuscript.
   5. *VSVkernelCalibration.m*:
   - Calibrates GATE's output dose kernel to a VSV kernel.
   - STEP 2 of VSV dosimetry in the thesis manuscript.
