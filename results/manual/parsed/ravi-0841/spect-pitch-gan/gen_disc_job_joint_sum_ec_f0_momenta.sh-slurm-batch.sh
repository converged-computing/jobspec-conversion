#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --constraint=ntasks-per-node=1

export SINGULARITY_HOME='$PWD:/home/$USER'

module load cuda/10.1
module load singularity
cd $HOME/data/ravi/spect-pitch-gan
export SINGULARITY_HOME=$PWD:/home/$USER
singularity exec --nv ./tf_1_12.simg python3 main_joint_ec_f0_momenta.py --lambda_cycle_pitch $1 --lambda_cycle_energy $2 --lambda_identity_energy 0.0 --lambda_momenta 1e-06 --generator_learning_rate 1e-05 --discriminator_learning_rate 1e-07 --emotion_pair $3
