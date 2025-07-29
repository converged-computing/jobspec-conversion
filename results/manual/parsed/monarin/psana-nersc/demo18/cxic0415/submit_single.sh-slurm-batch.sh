#!/bin/bash
#SBATCH --job-name=ps2cctbx
#SBATCH --account=m2859
#SBATCH --nodes=100
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --qos=premium
#SBATCH: --exclusive
#SBATCH --constraint=knl,quad,cache

export PMI_MMAP_SYNC_WAIT_TIME='600'

singularity
exec
docker:monarin/ps2cctbx:latest
t_start=`date +%s`
export PMI_MMAP_SYNC_WAIT_TIME=600
MAX_EVENTS=0 
sbcast -p ./input/process_batch.phil /tmp/process_batch.phil
srun -n 6800 -c 4 --cpu_bind=cores shifter ./index_single.sh cxic0415 50 0 none $MAX_EVENTS ${PWD}/output
t_end=`date +%s`
echo PSJobCompleted TotalElapsed $((t_end-t_start)) $t_start $t_end
