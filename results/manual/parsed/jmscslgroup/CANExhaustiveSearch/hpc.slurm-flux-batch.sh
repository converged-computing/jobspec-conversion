#!/bin/bash
#FLUX: --job-name=CAN_EXHAUSTIVE
#FLUX: -c=70
#FLUX: --queue=standard
#FLUX: -t=720000
#FLUX: --priority=16

pwd; hostname; date
now=$(date +"%Y_%m_%d_%H_%M_%S")
echo "CPUs per task: $SLURM_CPUS_PER_TASK"
module load matlab/r2020b
ulimit -u 63536
echo $now
matlab -nodisplay -nosplash -softwareopengl < /home/u27/rahulbhadani/CANExhaustiveSearch/CorrSignal_impl.m > /home/u27/rahulbhadani/CANExhaustiveSearch/output_pbs_$now.txt
date
