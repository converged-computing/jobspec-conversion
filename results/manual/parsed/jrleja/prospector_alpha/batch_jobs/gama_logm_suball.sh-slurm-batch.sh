#!/bin/bash
#SBATCH --job-name=gama_logm
#SBATCH --output=gama_logm_%a.out
#SBATCH --error=gama_logm_%a.err
#SBATCH --mail-user=joel.leja@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=4-00:00:00

IDFILE=$APPS"/prospector_alpha/data/gama.ids"
OBJID=$(sed -n "${SLURM_ARRAY_TASK_ID}p" "$IDFILE")
srun -n $SLURM_NTASKS --mpi=pmi2 python $APPS/prospector/scripts/prospector_dynesty.py \
--param_file="$APPS"/prospector_alpha/parameter_files/gama_logm_params.py \
--objname="$OBJID" \
--outfile="$APPS"/prospector_alpha/results/gama_logm/"$OBJID"
