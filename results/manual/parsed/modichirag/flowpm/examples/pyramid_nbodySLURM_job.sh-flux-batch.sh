#!/bin/bash
#FLUX: --job-name=arid-fork-9320
#FLUX: --exclusive
#FLUX: -t=1800
#FLUX: --priority=16

module purge && module load  esslurm gcc/7.3.0 python3 cuda/10.1.243
hsize=16
nx=2
ny=4
gpus_per_task=8
suffix="_test"
for nc in 128; do
    echo
    echo $nc
    echo
    time srun python -u pyramid_nbody_SLURM.py  --suffix=$suffix --nbody=True --gpus_per_task=$gpus_per_task --nc=$nc --batch_size=1 --mesh_shape="row:$nx;col:$ny" --nx=$nx --ny=$ny --hsize=$hsize  > log_pyramidnbody
done
