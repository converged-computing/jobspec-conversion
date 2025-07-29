#!/bin/bash
#SBATCH --job-name=uncertainty
#SBATCH --output=outputs/uncertainty-%A-%a.out
#SBATCH --error=outputs/uncertainty-%A-%a.out
#SBATCH --mail-user=ngochuyn@nmbu.no
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64G

export NUM_CPUS='4'
export RAY_ROOT='$TMPDIR/ray'
export MAX_SAVE_STEP_GB='0'

module load singularity
if [ $# -lt 2 ];
    then
    printf "Not enough arguments - %d\n" $#
    exit 0
    fi
echo "Finished seting up files."
export NUM_CPUS=4
export RAY_ROOT=$TMPDIR/ray
export MAX_SAVE_STEP_GB=0
rm -rf $TMPDIR/ray/*
singularity exec --nv deoxys-2023-feb-fixed.sif python -u run_uncertainty.py $1 $PROJECTS/ngoc/segmentation --dropout_rate $2 --iter $SLURM_ARRAY_TASK_ID
