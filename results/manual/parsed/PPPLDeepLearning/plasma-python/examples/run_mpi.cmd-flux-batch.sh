#!/bin/bash
#FLUX: --job-name=angry-despacito-8091
#FLUX: -N=25
#FLUX: -c=4
#FLUX: -t=3600
#FLUX: --urgency=16

module load anaconda
module load cudatoolkit/8.0 cudann/cuda-8.0/5.1 openmpi/intel-17.0/1.10.2/64 intel/17.0/64/17.0.2.174
rm -rf /tigress/jk7/model_checkpoints/*.h5
srun python mpi_learn.py
echo "done."
