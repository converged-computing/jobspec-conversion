#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/sameera2004/MMTI_Data_Processing/ALFF_data/seawulf_codes/submit_afni_HdrImg_nii.sh
