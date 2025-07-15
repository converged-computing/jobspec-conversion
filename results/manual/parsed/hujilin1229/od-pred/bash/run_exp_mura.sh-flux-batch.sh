#!/bin/bash
#FLUX: --job-name=dinosaur-arm-4364
#FLUX: -N=8
#FLUX: -c=24
#FLUX: -t=86400
#FLUX: --urgency=16

echo Running on "$(hostname)"
echo Available nodes: "$SLURM_NODELIST"
echo Slurm_submit_dir: "$SLURM_SUBMIT_DIR"
echo Start time: "$(date)"
nvidia-smi
module load intel/2018.05
module load openmpi/3.0.2
srun -n 8 --exclusive python resnet_tf_hvd.py 
wait
