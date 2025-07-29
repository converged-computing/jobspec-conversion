#!/bin/bash
#FLUX: --job-name=Python
#FLUX: --queue=savio2_htc
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

echo "Starting submit on host ${HOST}..."
echo "Loading modules..."
module load gcc/4.8.5 cmake python/3.6 cuda tensorflow
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
python3 run.py -f Ling.seq3.quality.root -o Results -a TMVA:BDT
wait
