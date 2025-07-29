#!/bin/bash
#SBATCH --job-name=3d_ha_sec
#SBATCH --output=td_dynamic_sec_%a.out
#SBATCH --error=td_dynamic_sec_%a.err
#SBATCH --mail-user=joel.leja@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=16:00:00
#SBATCH --partition=conroy,shared,serial_requeue,conroy-intel

IDFILE=$APPS"/prospector_alpha/data/3dhst/td_dynamic.ids"
OBJID=$(sed -n "${SLURM_ARRAY_TASK_ID}p" "$IDFILE")
python $APPS/prospector_alpha/code/td/postprocessing.py \
$APPS/prospector_alpha/parameter_files/td_dynamic_params.py \
--objname="$OBJID" \
--overwrite=True \
--plot=True \
--shorten_spec=True
