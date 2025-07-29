#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=06:00:00

export CUDA_VISIBLE_DEVICES='0'
export SLURM_TMPDIR='/home/mila/c/chris.emezue/scratch/SINGULARITY_CDT_TMP_DIR'

module load singularity/3.7.1
source /home/mila/c/chris.emezue/gsl-env/bin/activate
export CUDA_VISIBLE_DEVICES=0
export SLURM_TMPDIR=/home/mila/c/chris.emezue/scratch/SINGULARITY_CDT_TMP_DIR
singularity exec --nv -B $SLURM_TMPDIR:/tmp $SLURM_TMPDIR/gflownet_correct3.simg python3 get_cpdag.py
