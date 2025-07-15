#!/bin/bash
#FLUX: --job-name=CA_EX10_stream
#FLUX: --priority=16

set -x
set -v
module load cuda
srun ../bin/matmul_gpu > matmul_gpu.csv
touch ready
