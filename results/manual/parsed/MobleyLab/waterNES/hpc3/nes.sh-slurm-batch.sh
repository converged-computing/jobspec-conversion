#!/bin/bash
#SBATCH --account=DMOBLEY_LAB
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1

source ~/bin/gmx2022.1/bin/GMXRC
bash "$RUN_SCRIPT" -d "$SYSTEM_DIR"/stage"$STAGE" -t "$SYSTEM_DIR" -x gmx \
  -o "-ntmpi $SLURM_CPUS_PER_TASK" -s "$STAGE" -p NES -n "$SLURM_ARRAY_TASK_ID"
