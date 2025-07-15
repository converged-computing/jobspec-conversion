#!/bin/bash
#FLUX: --job-name=CA_EX9_stream
#FLUX: --priority=16

set -x
set -v
module load cuda
srun ../bin/stream_gpu >jacobi_100ms.csv
touch ready
