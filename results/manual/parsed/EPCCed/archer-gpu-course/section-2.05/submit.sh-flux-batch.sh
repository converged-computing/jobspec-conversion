#!/bin/bash
#FLUX: --job-name=blue-leopard-7463
#FLUX: --queue=gpu
#FLUX: -t=60
#FLUX: --priority=16

module load nvidia/nvhpc
./a.out
