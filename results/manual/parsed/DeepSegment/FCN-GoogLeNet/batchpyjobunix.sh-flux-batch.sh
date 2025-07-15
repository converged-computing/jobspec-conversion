#!/bin/bash
#FLUX: --job-name=misunderstood-lizard-4997
#FLUX: --urgency=16

module add cudnn/5.1-cuda-8.0
module load anaconda/py35/4.2.0
source activate tensorflow
module load i-compilers/17.0.1
module load intelmpi/17.0.1
mpirun -np 1 python ./inception_FCN.py > my_output_file
source deactivate
