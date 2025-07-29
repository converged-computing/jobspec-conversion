#!/bin/bash
#SBATCH --job-name={SLURM_JOB_NAME}
#SBATCH --output={SLURM_OUTPUT_LOG}
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --mem={SLURM_MEM}
#SBATCH --time=1-00:00:00
#SBATCH --qos=normal

echo "
Slurm Environment Variables:
- SLURM_JOBID=$SLURM_JOBID
- SLURM_JOB_NODELIST=$SLURM_JOB_NODELIST
- SLURM_NNODES=$SLURM_NNODES
- SLURMTMPDIR=$SLURMTMPDIR
- SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR
"
source ~/.bashrc
project_dir="/atlas/u/chrisyeh/africa_poverty/"
echo "Setting directory to: $project_dir"
cd $project_dir
echo "
Basic system information:
- Date: $(date)
- Hostname: $(hostname)
- User: $USER
- pwd: $(pwd)
"
conda activate py37
{content}
echo "All jobs launched!"
echo "Waiting for child processes to finish..."
wait
echo "Done!"
