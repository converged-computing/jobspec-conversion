#!/bin/bash
#FLUX: --job-name=sticky-signal-8816
#FLUX: --queue=g100_usr_interactive
#FLUX: -t=1200
#FLUX: --urgency=16

module load profile/deeplrn autoload tensorflow/1.10.0--python--3.6.4
tensorboard dev upload --logdir ./samples/puzzle_mnist_3_3_40000_CubeSpaceAE_AMA4Conv_withOUT_extra_loss/logs/c21764c27e99bdd900e708b87b5d3BIS \
  --name "Simple experiment with MNIST" \
  --description "Training results from ...." \
  --one_shot
