# H1 Stoichiometric Calibration of HU to tissue parameters

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

The code developed in this folder aims to:
 1. Define a stoichiometric calibration of HU to tissue parameters for the CT
 component of the in-house Gemini scanner, using a tube voltage of 120 kV, 195
 mAs and a slice thickness of  1 mm;
 2. Generate GATE's input files based on the obtained calibration.
