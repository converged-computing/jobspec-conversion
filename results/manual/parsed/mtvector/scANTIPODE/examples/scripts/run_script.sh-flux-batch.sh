#!/bin/bash
#FLUX: --job-name=antipode_script
#FLUX: --queue=celltypes
#FLUX: -t=259200
#FLUX: --priority=16

source ~/.bashrc
!nvidia-smi
conda activate pyro
python ~/Matthew/code/scANTIPODE/examples/RunDev-CleanedFixMemLeak-Longer-cere-NoDN.py
