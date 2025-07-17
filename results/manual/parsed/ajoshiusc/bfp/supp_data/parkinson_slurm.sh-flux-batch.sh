#!/bin/bash
#FLUX: --job-name=goodbye-dog-3822
#FLUX: -n=4
#FLUX: -t=36000
#FLUX: --urgency=16

echo ${subid}
module load gcc/8.3.0 motif zlib mesa
module load matlab
matlab -nodisplay -nosplash -r "addpath(genpath('/project/ajoshi_27/code_farm/bfp/src')); setenv('BrainSuiteMCR','/project/ajoshi_27/MATLAB_Runtime/v912'); bfp /project/ajoshi_27/code_farm/bfp/supp_data/config_bfp_preproc_minimal_carc.ini /scratch1/ajoshi/parkinsons_fmri/taowu/${subid}/anat/${subid}_T1w.nii.gz /scratch1/ajoshi/parkinsons_fmri/taowu/${subid}/func/${subid}_task-resting_bold.nii.gz /scratch1/ajoshi/parkinsons_fmri/taowu_bfp_out ${subid} task-resting ''"
exit 0
