#!/bin/bash
#FLUX: --job-name="render"
#FLUX: --queue=normal
#FLUX: -t=900
#FLUX: --priority=16

module load daint-gpu ParaView
srun -n $SLURM_NTASKS  --cpu_bind=sockets pvbatch script-movie.py --frames ${SLURM_ARRAY_TASK_ID}
