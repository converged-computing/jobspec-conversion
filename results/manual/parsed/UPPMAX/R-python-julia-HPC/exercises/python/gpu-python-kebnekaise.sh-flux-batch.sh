#!/bin/bash
#FLUX: --job-name=gassy-plant-9752
#FLUX: -t=600
#FLUX: --urgency=16

module load GCC/11.2.0 OpenMPI/4.1.1 Python/3.9.6 SciPy-bundle/2021.10 TensorFlow/2.7.1
python my_tf_program.py
