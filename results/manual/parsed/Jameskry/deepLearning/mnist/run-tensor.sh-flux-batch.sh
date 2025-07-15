#!/bin/bash
#FLUX: --job-name=TensorFlowTest
#FLUX: --queue=gpu
#FLUX: -t=300
#FLUX: --priority=16

module load gcc/4.9.1 cuda/8.0 cudnn/5.1 python3/3.5.2 tensorflow-gpu/1.0.0
python3 /home/05268/junma7/TensorFlow-Examples/examples/2_BasicModels/random_forest.py 
