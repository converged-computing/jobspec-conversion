#!/bin/bash
#FLUX: --job-name="SCELoss"
#FLUX: -c=12
#FLUX: --queue=gpgpu
#FLUX: -t=21600
#FLUX: --priority=16

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
cd /data/cephfs/punim0784/SCELoss
module load PyTorch/1.1.0-intel-2017.u2-Python-3.6.4-cuda10
nvidia-smi
python3 -u train.py   --epoch   120      \
                      --nr      0.6      \
                      --loss    SCE      \
                      >>logs/0.6nr_sce.log
