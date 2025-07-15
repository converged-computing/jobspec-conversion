#!/bin/bash
#FLUX: --job-name=transformer-xl
#FLUX: -c=40
#FLUX: --queue=akya-cuda
#FLUX: -t=518400
#FLUX: --priority=16

module load /truba/home/umutlu/cuda_9.0_module
srun bash run_papers_base.sh train --work_dir experiments
