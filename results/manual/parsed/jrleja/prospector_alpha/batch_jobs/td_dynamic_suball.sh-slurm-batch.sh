#!/bin/bash
#SBATCH --job-name=td_dynamic
#SBATCH --output=td_dynamic_%a.out
#SBATCH --error=td_dynamic_%a.err
#SBATCH --mail-user=joel.leja@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=7-00:00:00

IDFILE=$APPS"/prospector_alpha/data/3dhst/td_dynamic.ids"
OBJID=$(sed -n "${SLURM_ARRAY_TASK_ID}p" "$IDFILE")
srun -n 1 --mpi=pmi2 python $APPS/prospector/scripts/prospector_dynesty.py \
--param_file="$APPS"/prospector_alpha/parameter_files/td_dynamic_params.py \
--objname="$OBJID" \
--outfile="$APPS"/prospector_alpha/results/td_dynamic/"$OBJID" \
--runname="td_dynamic"
