#!/bin/bash
#SBATCH --job-name=weak_julia
#SBATCH --output=julia_weak_%a.out
#SBATCH --mail-user=mfricke@unm.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=00:05:00
#SBATCH --partition=general
#SBATCH --array=1-7

export OMP_NUM_THREADS='$SCALE_FACTOR'

OUTPUT_PATH=juliaset_weak_$SLURM_ARRAY_TASK_ID.tga
SCALE_FACTOR=$((2 ** ($SLURM_ARRAY_TASK_ID-1)))
export OMP_NUM_THREADS=$SCALE_FACTOR
FRACTAL_HEIGHT=$((10000*$SCALE_FACTOR))
FRACTAL_WIDTH=2000
echo Scale Factor: $SCALE_FACTOR
echo Number of Threads: $OMP_NUM_THREADS
echo FRACTAL_DIMS: $FRACTAL_HEIGHT x $FRACTAL_WIDTH
./juliaset $FRACTAL_HEIGHT $FRACTAL_WIDTH $OUTPUT_PATH
