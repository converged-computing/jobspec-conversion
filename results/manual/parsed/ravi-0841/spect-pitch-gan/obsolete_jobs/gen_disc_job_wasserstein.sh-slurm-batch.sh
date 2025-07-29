#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --time=1-06:00:00
#SBATCH --partition=gpuk80
#SBATCH --constraint=ntasks-per-node=1

export SINGULARITY_HOME='$PWD:/home/$USER'

module load cuda/10.1
module load singularity
cd $HOME/data/ravi/spect-pitch-gan
singularity pull --name tf.simg shub://ravi-0841/singularity-tensorflow-spg
export SINGULARITY_HOME=$PWD:/home/$USER
singularity exec --nv ./tf.simg python3 main_wasserstein.py --lambda_cycle_pitch $1 --lambda_cycle_mfc $2 --lambda_identity_mfc $3 --lambda_momenta $4 --generator_learning_rate $5 --discriminator_learning_rate $6
