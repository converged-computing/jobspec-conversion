#!/bin/bash
#FLUX: --job-name=fitMAGE
#FLUX: --queue=conroy_priority,itc_cluster,shared,serial_requeue
#FLUX: -t=180
#FLUX: --urgency=16

module load python
source /n/home03/vchandra/.bashrc
source activate outerhalo
cd /n/home03/vchandra/outerhalo/08_mage/
python -u 01_runstar.py "${SLURM_ARRAY_TASK_ID}" --version='h3'
