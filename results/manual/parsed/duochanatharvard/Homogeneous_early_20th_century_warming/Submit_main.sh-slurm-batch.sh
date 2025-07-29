#!/bin/bash
#SBATCH --job-name=cor_glb
#SBATCH --account=${group_account}
#SBATCH --output=logs/log_step_07_cor_glb.%A.%a
#SBATCH --error=logs/err_step_07_cor_glb.%A.%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30000
#SBATCH --time=1-01:00:00
#SBATCH --partition=${partition_main}
#SBATCH --array=1-4
#SBATCH --dependency=${JOB_cor_stats}

export partition_main='huce_intel"                # TODO'
export group_account='huybers_lab"                  # TODO'
export JOB_pairing='$(sbatch << EOF | egrep -o -e "\b[0-9]+$'
export JOB_combine_pairs='$(sbatch << EOF | egrep -o -e "\b[0-9]+$'
export JOB_LME='$(sbatch << EOF | egrep -o -e "\b[0-9]+$'
export JOB_cor_idv='$(sbatch << EOF | egrep -o -e "\b[0-9]+$'
export JOB_cor_rnd='$(sbatch << EOF | egrep -o -e "\b[0-9]+$'
export JOB_cor_stats='$(sbatch << EOF | egrep -o -e "\b[0-9]+$'
export JOB_cor_glb='$(sbatch << EOF | egrep -o -e "\b[0-9]+$'

export partition_main="huce_intel"                # TODO
export group_account="huybers_lab"                  # TODO
mkdir -p logs
export JOB_pairing=$(sbatch << EOF | egrep -o -e "\b[0-9]+$"
matlab -nosplash -nodesktop -nojvm -nodisplay -r "HM_load_package; num=\$SLURM_ARRAY_TASK_ID; HM_Step_01_02_Run_Pairs_dup; quit;"
EOF
)
echo submitted job ${JOB_pairing} for pairing SSTs
export JOB_combine_pairs=$(sbatch << EOF | egrep -o -e "\b[0-9]+$"
matlab -nosplash -nodesktop -nojvm -nodisplay -r "HM_load_package; HM_Step_03_SUM_Pairs_dup; quit;"
EOF
)
echo submitted job ${JOB_combine_pairs} for combining pairs
export JOB_LME=$(sbatch << EOF | egrep -o -e "\b[0-9]+$"
matlab -nosplash -nodesktop -nojvm -nodisplay -r "HM_load_package; HM_Step_04_LME_cor_err_dup; quit;"
EOF
)
echo submitted job ${JOB_LME} for estimating groupwise offsets using LME
export JOB_cor_idv=$(sbatch << EOF | egrep -o -e "\b[0-9]+$"
matlab -nosplash -nodesktop -nojvm -nodisplay -r "HM_load_package; num=\$SLURM_ARRAY_TASK_ID; HM_Step_05_Corr_Idv; quit;"
EOF
)
echo submitted job ${JOB_cor_idv} for correcting for maximum likelihood estimates of offsets
export JOB_cor_rnd=$(sbatch << EOF | egrep -o -e "\b[0-9]+$"
matlab -nosplash -nodesktop -nojvm -nodisplay -r "HM_load_package; num=\$SLURM_ARRAY_TASK_ID; HM_Step_06_Corr_Rnd; quit;"
EOF
)
echo submitted job ${JOB_cor_rnd} for correcting for maximum likelihood estimates of offsets
export JOB_cor_stats=$(sbatch << EOF | egrep -o -e "\b[0-9]+$"
matlab -nosplash -nodesktop -nojvm -nodisplay -r "HM_load_package; num=\$SLURM_ARRAY_TASK_ID; HM_Step_07_SUM_Corr; quit;"
EOF
)
echo submitted job ${JOB_cor_stats} for computing statistics of computations
export JOB_cor_glb=$(sbatch << EOF | egrep -o -e "\b[0-9]+$"
matlab -nosplash -nodesktop -nojvm -nodisplay -r "HM_load_package; num=\$SLURM_ARRAY_TASK_ID; HM_Step_08_Merge_GC; quit;"
EOF
)
echo submitted job ${JOB_cor_glb} for merging common bucket bias corrections
