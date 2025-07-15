#!/bin/bash
#FLUX: --job-name=fat-caramel-9999
#FLUX: -t=86400
#FLUX: --priority=16

module load git/1.8.3.1
module load openmpi/1.8/gcc/4.7/cpu
module load gcc
module load slurm
module load anaconda/4.3.1 cuda/toolkit/9.0 cuda/libs/cudnn-7005
source /c1/libs/glibc/2.17/site-packages/bin/activate;
/c1/libs/glibc/2.17/lib/x86_64-linux-gnu/ld-2.17.so --library-path /c1/libs/glibc/2.17/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH:/usr/lib /c1/apps/anaconda/4.3.1/bin/python ./main.py;
