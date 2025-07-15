#!/bin/bash
#FLUX: --job-name="KerasMLP"
#FLUX: -t=86400
#FLUX: --priority=16

module load python/3.6.1
module load keras/2.1.3-py36
module load tensorflow/1.6.0-py36-gpu
python /OSM/CBR/AF_WQ/source/Franz/Keras_many_to_many/MLP/MLP_keras_HPC.py 2000 10 6
