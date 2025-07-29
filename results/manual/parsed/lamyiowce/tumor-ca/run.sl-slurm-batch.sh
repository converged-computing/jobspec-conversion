#!/bin/bash
#SBATCH --account=G74-17
#SBATCH --output=slurm%A_%a.out
#SBATCH --mail-user=j.bazinska@student.uw.edu.pl
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --array=[1-32]

export LD_LIBRARY_PATH='/icm/home/bazinska/miniconda3/lib:$LD_LIBRARY_PATH'

export LD_LIBRARY_PATH="/icm/home/bazinska/miniconda3/lib:$LD_LIBRARY_PATH"
./tumor ../resources/tumors/out-vnw-tr1-st0-0a-initial.json \
../protocol_generator/data/protocol_times_${SLURM_ARRAY_TASK_ID}.csv ./results/generated/ ${SLURM_ARRAY_TASK_ID} 144000
