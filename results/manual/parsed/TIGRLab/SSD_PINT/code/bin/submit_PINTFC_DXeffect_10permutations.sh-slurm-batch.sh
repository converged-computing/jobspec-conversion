#!/bin/bash
#SBATCH --job-name=R_DXboots
#SBATCH --output=logs/%x_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=12000
#SBATCH --time=02:00:00

BASEDIR=${SLURM_SUBMIT_DIR}
function cleanup_ramdisk {
    echo -n "Cleaning up ramdisk directory /$SLURM_TMPDIR/ on "
    date
    rm -rf /$SLURM_TMPDIR
    echo -n "done at "
    date
}
trap "cleanup_ramdisk" TERM
module load R
mkdir -p /home/edickie/R/x86_64-pc-linux-gnu-library/4.1
Rscript ./code/R/running_bootedperm_DXeffects_PINTFC.R $SLURM_ARRAY_TASK_ID
