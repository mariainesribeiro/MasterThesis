# Stoichiometric Calibration of HU to tissue parameters

Converting CT numbers, in HU, to tissue parameters yields the input for MC-GATE
dosimetry simulations that account for tissue heterogeneity.
GATE requires a linear calibration of HU to mass density and a discrete
calibration of HU to chemical composition.
When an MC-GATE dosimetry simulation is initialized, the code automatically
assigns the adequate tissue parameters to each voxel in a CT image, generating
a geometry that mimics patient-specific tissue heterogeneity.

HU are scanner-dependent due to variations in the x-ray spectral energy
function, effective x-ray energy, detector energy, scanner diameter, and image
matrix size. Therefore, it is mandatory to obtain a calibration specific to the
in-house CT scanner and clinical scanning protocol.

**The code developed in this folder aims to:**
- Define a stoichiometric calibration of HU to tissue parameters for the CT
 component of the in-house Gemini scanner, using a tube voltage of 120 kV, 195
 mAs and a slice thickness of  1 mm;
- Generate GATE's input files based on the obtained calibration.

*Read Section 4.2 for more detailed information.*

## Files

1. **Gemini_CT_Calibration.m** <-- main file
  - Fits k1 and k2 to parametrize the Gemini CT scanner with tissue substitutes
  in CATPHAN 604;
  - Computes HU according to the parametrized k1 and k2 values for:
    - Tissue substitutes,
    - ICRP standard tissues, and
    - Representative tissues.


2. **CATPHAN604_data.mat**
  - Describes the chemical composition and mass density of each tissue
  substitute in CATPHAN 604, and reports the mean HU measured bu the Gemini CT
  scanner for each tissue substitute.

3. **ICRP.mat**
  - Describes the chemical composition and mass density of each ICRP standard
  tissue.

4. **representative_tissues.mat**
  - Describes the chemical composition and mass density of each representative tissue.

5. **GATE's files to calibrate HU to tisse parameters**
    - **GEMINIDensitiesTable.mat**: generated file to calibrate HU to mass density.
    - **GEMINIMaterialsTable.mat**: generated file to calibrate HU to chemical composition.
