#!/bin/bash
#SBATCH --job-name=ABM_Simulation_Parameter_Sweep
#SBATCH --output=param_sweep_job-%a.out
#SBATCH --error=param_sweep_job-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-23:55:00
#SBATCH --array=1-40

echo "Starting job $SLURM_ARRAY_TASK_ID on $HOSTNAME"
matlab-threaded -nodisplay -r "coculture_model($SLURM_ARRAY_TASK_ID); exit"
