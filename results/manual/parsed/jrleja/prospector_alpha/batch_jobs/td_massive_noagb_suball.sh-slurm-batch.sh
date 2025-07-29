#!/bin/bash
#SBATCH --job-name=td_mass
#SBATCH --output=td_massive_noagb_%a.out
#SBATCH --error=td_massive_noagb_%a.err
#SBATCH --mail-user=joel.leja@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3000
#SBATCH --time=1-00:00:00
#SBATCH --partition=conroy,general,conroy-intel

IDFILE=$APPS"/prospector_alpha/data/3dhst/td_massive.ids"
OBJID=$(sed -n "${SLURM_ARRAY_TASK_ID}p" "$IDFILE")
srun -n $SLURM_NTASKS --mpi=pmi2 python $APPS/prospector/scripts/prospector.py \
--param_file="$APPS"/prospector_alpha/parameter_files/td_massive_noagb_params.py \
--objname="$OBJID" \
--outfile="$APPS"/prospector_alpha/results/td_massive_noagb/"$OBJID"
