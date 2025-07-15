#!/bin/bash
#FLUX: --job-name=Musa
#FLUX: -t=86400
#FLUX: --urgency=16

njobs=$1
nprocs=$2
python clean.py
cat << end_jobarray > slurmScript.sh
module load gcc
module load conda
conda activate MuSA
cd "\${SLURM_SUBMIT_DIR}"
python main.py "${njobs}" "${nprocs}" "\${SLURM_ARRAY_TASK_ID}"
end_jobarray
sbatch slurmScript.sh
rm slurmScript.sh
