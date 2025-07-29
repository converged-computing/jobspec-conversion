#!/bin/bash
#SBATCH --output=neuralpde_jobarray.log-%A-%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --array=1-128

export LOG_DIR='/home/gridsan/zmccarthy/logs/spme_c_e_first'
export SLURM_ARRAY_TASK_ID='$SLURM_ARRAY_TASK_ID'
export SLURM_ARRAY_TASK_COUNT='$SLURM_ARRAY_TASK_COUNT'

source /home/gridsan/zmccarthy/.julia_profile
export LOG_DIR="/home/gridsan/zmccarthy/logs/spme_c_e_first"
export SLURM_ARRAY_TASK_ID=$SLURM_ARRAY_TASK_ID
export SLURM_ARRAY_TASK_COUNT=$SLURM_ARRAY_TASK_COUNT
echo "args:"
echo $SLURM_ARRAY_TASK_ID
echo $SLURM_ARRAY_TASK_COUNT
echo $LOG_DIR
julia $DFNEXPERIMENTS_DIR/test/pybamm_generate_spme.jl 
