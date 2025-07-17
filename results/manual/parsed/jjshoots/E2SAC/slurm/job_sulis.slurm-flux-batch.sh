#!/bin/bash
#FLUX: --job-name=bloated-nalgas-8509
#FLUX: -c=42
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load GCC/10.2.0  CUDA/11.1.1  OpenMPI/4.0.5
module load PyTorch/1.9.0
module load torchvision/0.10.0-PyTorch-1.9.0
source ~/.bashrc
source /venv/bin/activate
NJOBS=`squeue -h --node=$(hostname -s) --user=$SLURM_JOB_USER | wc -l`
screen="-screen 0 1400x900x24"
if [[ $NJOBS -gt 1 ]]; then
  screen="-screen 1 1400x900x24";
fi
xvfb-run -s "$screen" wandb agent --count=1 jjshoots/UA3SAC_gym/yp3kgbaf
