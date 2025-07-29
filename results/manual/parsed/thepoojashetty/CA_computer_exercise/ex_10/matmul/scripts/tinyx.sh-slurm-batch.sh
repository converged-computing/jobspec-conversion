#!/bin/bash
#FLUX: --job-name=CA_EX10_stream
#FLUX: -t=7200
#FLUX: --urgency=16

set -x
set -v
module load cuda
srun ../bin/matmul_gpu > matmul_gpu.csv
touch ready
