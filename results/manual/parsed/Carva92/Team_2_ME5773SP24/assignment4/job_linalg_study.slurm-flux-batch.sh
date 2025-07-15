#!/bin/bash
#FLUX: --job-name=expensive-blackbean-0850
#FLUX: --priority=16

echo "Starting job_linalg_study.slurm"
module load anaconda3
conda activate envTeam2
MKL_VALUES=(1 2 4 8 16 20 40)
for MKL_NUM_THREADS in "${MKL_VALUES[@]}"
do
    echo "Running with MKL_NUM_THREADS=$MKL_NUM_THREADS"
    # Set the MKL_NUM_THREADS
    export MKL_NUM_THREADS=$MKL_NUM_THREADS
    # Run the linalg.py script
    srun --exclusive -N1 -n1 -c $SLURM_CPUS_PER_TASK python3 linalg.py &
    wait
done
