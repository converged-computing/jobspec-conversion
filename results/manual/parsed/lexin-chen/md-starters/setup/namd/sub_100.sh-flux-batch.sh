#!/bin/bash
#FLUX: --job-name=w_mor
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --priority=16

ml cuda/10.0.130 namd/3.0
cd $SLURM_SUBMIT_DIR
/apps/cuda/11.0.207/base/namd/3.0/NAMD_3.0alpha7_Linux-x86_64-multicore-CUDA/namd3 step7_production4.inp>step7_production4.log
/apps/cuda/11.0.207/base/namd/3.0/NAMD_3.0alpha7_Linux-x86_64-multicore-CUDA/namd3 step7_production5.inp>step7_production5.log
