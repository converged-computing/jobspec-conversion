#!/bin/bash
#SBATCH --job-name=psim5
#SBATCH --account=nesi00119
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=01:00:00

ml SUNDIALS/4.1.0-gimkl-2018b
echo $HOSTNAME
echo "task array id: $SLURM_ARRAY_TASK_ID"
job_dir=$( head -n $SLURM_ARRAY_TASK_ID dirs.txt | tail -1 )
echo $job_dir
cd $job_dir
srun --ntasks=8 psim5
rm psim5
ml Python/3.7.3-gimkl-2018b
srun --ntasks=1 python "SCRIPT_DIR/summary_plot.py"
srun --ntasks=1 python "SCRIPT_DIR/summary_plot_averages.py"
