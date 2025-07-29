#!/bin/bash
#SBATCH --job-name=run_deepfacelab
#SBATCH --output=run_deepfacelab-id-%J.out
#SBATCH --mail-user=chenmis@post.bgu.ac.il
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=07:00:00

echo "SLURM_JOBID"=$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
module load anaconda                          ### load anaconda module
source activate py37   
bash -i ./2_extract_image_from_data_src.sh
