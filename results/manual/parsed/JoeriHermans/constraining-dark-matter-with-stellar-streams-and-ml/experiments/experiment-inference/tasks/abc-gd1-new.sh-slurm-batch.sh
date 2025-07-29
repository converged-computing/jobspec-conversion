#!/bin/bash
#SBATCH --job-name=STREAM_INFERENCE_ABC_GD1_NEW
#SBATCH --output=logging/abc_gd1_new.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=1-00:00:00

suffix=$(printf "%05d" $SLURM_ARRAY_TASK_ID)
out=$BASE/out/gd1/abc-new-$suffix
mkdir -p $out
if [ ! -f $out/samples.npy -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    python -u abc-new.py \
           --average \
           --auto \
           --threshold $EXPERIMENT_ABC_THRESHOLD \
           --ages $DATADIR/train/ages-r.npy \
           --masses $DATADIR/train/masses-r.npy \
           --observations $DATADIR/observed-noised.npy \
           --out $out \
           --outputs $DATADIR/train/density-contrasts-cut-noised.npy
fi
