#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=80G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=2

MODEL=$1
DATATYPE=$2
DATASET=$3
SEED=$4
AC=$5
module load Julia/1.5.1-linux-x86_64
module load Python/3.8.2-GCCcore-9.3.0
julia ./aae_disc_score.jl $MODEL $DATATYPE $DATASET $SEED $AC
