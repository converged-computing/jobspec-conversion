#!/bin/bash
#SBATCH --output=logs/sst-job-%A-%a.out
#SBATCH --error=logs/sst-job-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=1G
#SBATCH --time=02:00:00
#SBATCH --array=1-5

export DISABLE_PBAR='1'

module purge
module load miniconda
source activate bayes
export DISABLE_PBAR=1
MAX_STEPS=2000
OUTDIR="zoo/sst/edl"
METHOD="edl"
python train.py \
    --method $METHOD \
    --dataset SSTBERT --transform normalize_x_sst \
    --model SSTNetEDL \
    --max-steps $MAX_STEPS \
    --batch-size 256 \
    --outdir $OUTDIR \
    --prefix $METHOD-$SLURM_ARRAY_TASK_ID
