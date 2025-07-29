#!/bin/bash
#SBATCH --output=sample_log/goodrun_%j.o
#SBATCH --error=sample_log/goodrun_%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=80000
#SBATCH --time=00:03:45
#SBATCH --partition=fink_gpu

PROJDIR="/n/holylfs05/LABS/finkbeiner_lab/Users/nmudur/project_dirs/CMD_2D/diffusion-models-for-cosmological-fields/annotated/results/"
MODELRUN="Run_5-7_0-50/"
CKPFILE="checkpoint_160000.pt"
CHECKPOINT="$PROJDIR/samples_exps/$MODELRUN/$CKPFILE"
SAMPDIR="$PROJDIR/checkpoint_samples/$MODELRUN"
echo $CHECKPOINT
echo $SAMPDIR
module load Anaconda3/2020.11
module load CUDA/10.0.130
source activate pytorch_a100
/n/home02/nmudur/.conda/envs/pytorch_a100/bin/python sample_single_checkpoint.py --checkpoint $CHECKPOINT --savedir $SAMPDIR --num_params 50
