#!/bin/bash
#FLUX: --job-name=hairy-blackbean-8936
#FLUX: -n=4
#FLUX: -t=36000
#FLUX: --urgency=16

echo ${subid}
module load gcc/8.3.0 motif zlib mesa
module load matlab
matlab -nodisplay -nosplash -r "addpath(genpath('/project/ajoshi_27/code_farm/bfp/src')); setenv('BrainSuiteMCR','/project/ajoshi_27/MATLAB_Runtime/v912'); bfp /project/ajoshi_27/code_farm/bfp/supp_data/config_bfp_preproc_minimal_carc.ini /scratch1/ajoshi/parkinsons_fmri/neurocon/${subid}/anat/${subid}_T1w.nii.gz /scratch1/ajoshi/parkinsons_fmri/neurocon/${subid}/func/${subid}_task-resting_run-1_bold.nii.gz /scratch1/ajoshi/parkinsons_fmri/neurocon_bfp_out ${subid} task-resting-run-1 ''"
exit 0
