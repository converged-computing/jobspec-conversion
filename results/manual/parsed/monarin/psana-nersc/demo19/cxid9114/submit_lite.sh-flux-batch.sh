#!/bin/bash
#FLUX: --job-name=ps2cctbx
#FLUX: -N=4990
#FLUX: --exclusive
#FLUX: -t=1200
#FLUX: --priority=16

export PMI_MMAP_SYNC_WAIT_TIME='600'

t_start=`date +%s`
export PMI_MMAP_SYNC_WAIT_TIME=600
sbcast -p ./input/process_batch.phil /tmp/process_batch.phil
sbcast -p ./xtc_process.py /tmp/xtc_process.py
sbcast -p ./input/geom_ld91.json /tmp/geom_ld91.json
t_end_sbcast=`date +%s`
srun -n 339320 -c 4 --cpu_bind=cores -x=nid08201,nid11988 shifter ./index_lite.sh cxid9114 2 99 debug 0
t_end=`date +%s`
echo PSJobCompleted sbcast $((t_end_sbcast-t_start)) TotalElapsed $((t_end-t_start)) 
