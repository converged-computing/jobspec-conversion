#!/bin/bash
#SBATCH --job-name=run_DARTS
#SBATCH --output=log/%x.%N.%j.out
#SBATCH --error=log/%x.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=64000
#SBATCH --time=1-00:00:00
#SBATCH --partition=mlhiwidlc_gpu-rtx2080

export PATH='$PATH:/home/zabergjg/miniconda3/envs/naslib/lib/python3.7/'

source ~/.bashrc
conda activate DL_Lab
echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION";
export PATH=$PATH:/home/zabergjg/miniconda3/envs/naslib/lib/python3.7/
python run_darts.py
echo "DONE";
echo "Finished at $(date)";
