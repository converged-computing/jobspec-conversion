#!/bin/bash
#FLUX: --job-name=serial_julia
#FLUX: -c=32
#FLUX: --queue=general
#FLUX: -t=300
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

OUTPUT_PATH=juliaset_weak_$SLURM_ARRAY_TASK_ID.tga
SCALE_FACTOR=$((2 ** ($SLURM_ARRAY_TASK_ID-1)))
export OMP_NUM_THREADS=1
FRACTAL_HEIGHT=$((100*$SCALE_FACTOR))
FRACTAL_WIDTH=200
echo Scale Factor: $SCALE_FACTOR
echo Number of Threads: $OMP_NUM_THREADS
echo FRACTAL_DIMS: $FRACTAL_HEIGHT x $FRACTAL_WIDTH
./juliaset $FRACTAL_HEIGHT $FRACTAL_WIDTH $OUTPUT_PATH
