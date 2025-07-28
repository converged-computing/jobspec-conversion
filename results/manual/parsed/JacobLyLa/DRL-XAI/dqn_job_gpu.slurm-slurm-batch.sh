#!/bin/bash
#FLUX: --job-name=dqn_job_gpu
#FLUX: --queue=GPUQ
#FLUX: -t=1800
#FLUX: --urgency=16

module purge
module load PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
module list
python -m cProfile -s cumtime -o program.prof -m src.DRL.train_qrunner
