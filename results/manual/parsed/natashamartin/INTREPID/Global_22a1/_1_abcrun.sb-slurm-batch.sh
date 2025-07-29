#!/bin/bash
#SBATCH --job-name=bat1
#SBATCH --account=csd722
#SBATCH --output=%x.run_%a.out.txt
#SBATCH --error=%x.run_%a.err.txt
#SBATCH --mail-user=achaillon@health.ucsd.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=48GB
#SBATCH --time=2-00:00:00
#SBATCH --partition=ind-shared
#SBATCH --array=0-0

export PATH='/expanse/lustre/scratch/jpg/temp_project/matlab_2020b/bin:$PATH'

countries=( UA  )
export PATH=/expanse/lustre/scratch/jpg/temp_project/matlab_2020b/bin:$PATH
mkdir -p .matlab/local_cluster_jobs/R2019b/$SLURM_JOB_ID
module load matlab
matlab -nodisplay -r "Run_ABC('${countries[$SLURM_ARRAY_TASK_ID]}',1);exit"
rm -rf .matlab/local_cluster_jobs/R2019b/$SLURM_JOB_ID
