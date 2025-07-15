#!/bin/bash
#FLUX: --job-name=scruptious-latke-9445
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export LD_PRELOAD='/home1/apps/tacc-patches/getcwd-patch.so:$LD_PRELOAD'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export LD_PRELOAD=/home1/apps/tacc-patches/getcwd-patch.so:$LD_PRELOAD
conda activate base
python count.py
