#!/bin/bash
#SBATCH --job-name=My_Cool_Science
#SBATCH --output=tf_sing_job_%j.o
#SBATCH --error=tf_sing_job_%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

export SINGULARITY_BINDPATH='/gpfs/scratch,/gpfs/data'

echo Master process running on `hostname`
echo Directory is `pwd`
echo Starting execution at `date`
echo Current PATH is $PATH
export SINGULARITY_BINDPATH="/gpfs/scratch,/gpfs/data"
CONTAINER=/gpfs/rt/7.2/opt/tensorflow/22.05-tf2-py3/bin/tf2_22.05-tf2-py3.simg
SCRIPT=/gpfs/data/ccvstaff/psaluja/ccv_bootcamp/bootcamp_talk/pinn_laplace_TF2.py
singularity exec --nv $CONTAINER python $SCRIPT 
