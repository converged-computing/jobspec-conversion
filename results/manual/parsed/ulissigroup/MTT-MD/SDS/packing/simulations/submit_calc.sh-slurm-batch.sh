#!/bin/bash
#FLUX: --job-name=namd
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

export PATH='/home/zulissi/software/namd/Linux-x86_64-icc/:$PATH'

module purge;
ulimit -Sn 4096;
module load NAMD cuda
export PATH=/home/junwoony/Desktop/wham/wham:$PATH
export PATH=/home/zulissi/software/namd/Linux-x86_64-icc/:$PATH
namd2 +p4 +isomalloc_sync run_namd.conf
