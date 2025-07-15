#!/bin/bash
#FLUX: --job-name=muffled-peas-7813
#FLUX: --priority=16

export partition_preprocess='huce_intel"          # TODO'
export group_account='huybers_lab"                  # TODO'
export JOB_ascii2mat='$(sbatch << EOF | egrep -o -e "\b[0-9]+$'
export JOB_assign_missing='$(sbatch << EOF | egrep -o -e "\b[0-9]+$'
export JOB_winsorize='$(sbatch << EOF | egrep -o -e "\b[0-9]+$'
export JOB_neighbor_sigma='$(sbatch << EOF | egrep -o -e "\b[0-9]+$'
export JOB_buddy='$(sbatch << EOF | egrep -o -e "\b[0-9]+$'

export partition_preprocess="huce_intel"          # TODO
export group_account="huybers_lab"                  # TODO
mkdir logs
export JOB_ascii2mat=$(sbatch << EOF | egrep -o -e "\b[0-9]+$"
matlab -nosplash -nodesktop -nojvm -nodisplay -r "HM_load_package; num=\$SLURM_ARRAY_TASK_ID; ICOADS_Step_01_ascii2mat_sub; quit;"
EOF
)
echo submitted job ${JOB_ascii2mat} for converting ICOADS3.0 data from ASCII format to .mat files
export JOB_assign_missing=$(sbatch << EOF | egrep -o -e "\b[0-9]+$"
matlab -nosplash -nodesktop -nojvm -nodisplay -r "HM_load_package; num=\$SLURM_ARRAY_TASK_ID; ICOADS_Step_02_pre_QC_sub; quit;"
EOF
)
echo submitted job ${JOB_assign_missing} for assigning missing country information and measurement method
export JOB_winsorize=$(sbatch << EOF | egrep -o -e "\b[0-9]+$"
matlab -nosplash -nodesktop -nojvm -nodisplay -r "HM_load_package; num=\$SLURM_ARRAY_TASK_ID; ICOADS_Step_03_WM_sub; quit;"
EOF
)
echo submitted job ${JOB_winsorize} for computing winsorized mean of 5-day SST at 1 degree resolution
export JOB_neighbor_sigma=$(sbatch << EOF | egrep -o -e "\b[0-9]+$"
matlab -nosplash -nodesktop -nojvm -nodisplay -r "HM_load_package; ICOADS_Step_04_Neighbor_std_sub; quit;"
EOF
)
echo submitted job ${JOB_neighbor_sigma} for computing between-neighbor standard deviation
export JOB_buddy=$(sbatch << EOF | egrep -o -e "\b[0-9]+$"
matlab -nosplash -nodesktop -nojvm -nodisplay -r "HM_load_package; num=\$SLURM_ARRAY_TASK_ID; ICOADS_Step_05_Buddy_check_sub; quit;"
EOF
)
echo submitted job ${JOB_neighbor_sigma} for performing buddy check and other quality controls
