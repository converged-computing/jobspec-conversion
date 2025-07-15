#!/bin/bash
#FLUX: --job-name=lammps
#FLUX: -c=4
#FLUX: --queue=small-g
#FLUX: -t=14400
#FLUX: --priority=16

module load LUMI/23.09
module load LAMMPS/stable-12Aug2023-update2-pair-allegro-rocm-5.2.3-pytorch-1.13-20240303
CPU_BIND="map_cpu:49,57,17,25,1,9,33,41"
srun lmp -in myrun.inp > stdout.out 2> stderr.out
nequip-train inputs.yaml
nequip-deploy build --train-dir ./results/training model.pth
traindir=./results/training
nequip-evaluate --train-dir $traindir --dataset-config config.yaml --batch-size 400 --repeat 3 
