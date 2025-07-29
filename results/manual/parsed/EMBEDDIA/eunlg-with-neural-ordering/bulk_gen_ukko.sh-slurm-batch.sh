#!/bin/bash
#SBATCH --job-name=gen
#SBATCH --output=/wrk/users/eliel/projects/embeddia/eunlg/jobs/res/%A_%a.txt
#SBATCH --error=/wrk/users/eliel/projects/embeddia/eunlg/jobs/err/%A_%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=10G
#SBATCH --time=10:00:00
#SBATCH --chdir=/wrk/users/eliel/projects/embeddia/eunlg

module purge
module load Python/3.7.0-intel-2018b
module load CUDA/10.1.105
V=(neural_filter neural_filter_ctx_setpen neural_filter_ctx neural_filter_setpen baseline_filter list_baseline \
list_neural)
LOC=(DE FI EE AT HR SE)
ID=SLURM_ARRAY_TASK_ID
echo "BULK, PL, LOCS are: "
echo $BULK
echo $PL
echo $LOCS
srun $USERAPPL/ve37/bin/python3 eunlg/bulk_generate.py -l en -o $BULK -v $PL -d cphi --locations ${LOC[$ID]} \
--verbose
