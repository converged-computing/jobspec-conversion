#!/bin/bash
#FLUX: --job-name=NAMD-gpu
#FLUX: -c=8
#FLUX: -t=7200
#FLUX: --priority=16

module load namd/3.06b
cd $SLURM_SUBMIT_DIR
srun namd3 +ppn 8 +netpoll equil_min.namd > min.out
srun namd3 +ppn 8 +netpoll equil_k0.5_gpu.namd > namd.output
