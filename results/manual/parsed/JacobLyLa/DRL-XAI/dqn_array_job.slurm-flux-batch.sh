#!/bin/bash
#FLUX: --job-name=dqn_array_job_8cores
#FLUX: -c=8
#FLUX: --queue=CPUQ
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load PyTorch/2.0.1-foss-2022a
module list
python -m src.DRL.train_qrunner
