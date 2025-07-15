#!/bin/bash
#FLUX: --job-name=beam_collision_discriminator_trainer1
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=7800
#FLUX: --urgency=16

python training.py
