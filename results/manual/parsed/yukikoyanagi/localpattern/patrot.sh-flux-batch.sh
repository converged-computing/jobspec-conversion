#!/bin/bash
#FLUX: --job-name=milky-omelette-6260
#FLUX: -N=3
#FLUX: -t=7200
#FLUX: --urgency=16

echo Running on "$(hostname)"
echo Available nodes: "$SLURM_NODELIST"
echo Slurm_submit_dir: "$SLURM_SUBMIT_DIR"
echo Start time: "$(date)"
start=$(date +%s)
module purge
module load python-intel
srun python ./patrot.py
end=$(date +%s)
echo End time: "$(date)"
dur=$(date -d "0 $end sec - $start sec" +%T)
echo Duration: "$dur"
echo Done.
