#!/bin/bash
#FLUX: --job-name=single_core
#FLUX: -N=2
#FLUX: --queue=htc
#FLUX: -t=86400
#FLUX: --urgency=16

module load anaconda3/2019.03
module load gpu/cuda/10.0.130
module load gpu/cudnn/7.5.0__cuda-10.0
module load mpi
source activate $DATA/tensor-env
./meta_script_msweep_arc mnist fc none 1
