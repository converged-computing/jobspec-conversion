#!/bin/bash
#SBATCH --job-name=Buddy
#SBATCH --account=${group_account}
#SBATCH --output=logs/log_step_05_buddy.%A.%a
#SBATCH --error=logs/err_step_05_buddy.%A.%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5000
#SBATCH --time=08:20:00
#SBATCH --partition=${partition_preprocess}
#SBATCH --array=1-1200
#SBATCH --dependency=${JOB_assign_missing}

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
