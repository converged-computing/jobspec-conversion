#!/bin/bash
#SBATCH --account=uBS21_InfGer_0
#SBATCH --output=myJobTensor.out
#SBATCH --error=myJobTensor.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=00:20:00
#SBATCH --constraint=ntasks-per-node=1

module load profile/deeplrn autoload tensorflow/1.10.0--python--3.6.4
tensorboard dev upload --logdir ./samples/puzzle_mnist_3_3_40000_CubeSpaceAE_AMA4Conv_withOUT_extra_loss/logs/c21764c27e99bdd900e708b87b5d3BIS \
  --name "Simple experiment with MNIST" \
  --description "Training results from ...." \
  --one_shot
