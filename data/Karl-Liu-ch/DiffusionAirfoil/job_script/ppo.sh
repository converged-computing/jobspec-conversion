#!/bin/sh
### General options
### –- specify queue --
###BSUB -q gpua100
#BSUB -q gpuv100
###BSUB -q gpua10
### -- set the job Name --
#BSUB -J ppo
### -- ask for number of cores (default: 1) --
#BSUB -n 8
### -- specify that the cores must be on the same host --
#BSUB -R "span[hosts=1]"
### -- Select the resources: 1 gpu in exclusive process mode --
#BSUB -gpu "num=1:mode=exclusive_process"
### -- set walltime limit: hh:mm --  maximum 24 hours for GPU-queues right now
#BSUB -W 24:00
# request 100GB of system-memory
#BSUB -R "rusage[mem=20GB]"
### -- set the email address --
# please uncomment the following line and put in your e-mail address,
# if you want to receive e-mail notifications on a non-default address
#BSUB -u s212645@student.dtu.dk
### -- send notification at start --
#BSUB -B
### -- send notification at completion--
#BSUB -B
### -- Specify the output and error file. %J is the job-id --
### -- -o and -e mean append, -oo and -eo mean overwrite --
#BSUB -o ppo%J.out
#BSUB -e ppo%J.err
# -- end of LSF options --
module load cuda/11.8
module load cudnn/v8.9.1.23-prod-cuda-11.X 
cd /zhome/02/b/164706/
source ./miniconda3/bin/activate
conda activate pytorch
cd /zhome/02/b/164706/Master_Courses/2023_Fall/DiffusionAirfoil/
export PYTHONUNBUFFERED=1
python -u RL_algorithm.py --agent ppo