#!/bin/bash
#SBATCH --job-name=plot_hist
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=01:00:00
#SBATCH --partition=amd
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-44

cd /gpfs/terra/export/samba/gis/holgerv/river_quality/scripts/grqa_processing
module purge
module load python
source activate river_quality
code_file="/gpfs/terra/export/samba/gis/holgerv/GRQA_v1.3/GRQA_meta/GRQA_param_codes.txt"
readarray param_codes < ${code_file}
param_code=${param_codes[$SLURM_ARRAY_TASK_ID]}
~/.conda/envs/river_quality/bin/python plot_hist.py ${param_code}
