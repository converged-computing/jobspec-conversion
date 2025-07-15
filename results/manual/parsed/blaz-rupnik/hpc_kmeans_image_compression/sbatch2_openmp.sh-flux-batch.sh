#!/bin/bash
#FLUX: --job-name=carnivorous-cinnamonbun-1615
#FLUX: -c=64
#FLUX: -t=36000
#FLUX: --priority=16

export OMP_PLACES='cores'
export OMP_PROC_BIND='TRUE'

export OMP_PLACES=cores
export OMP_PROC_BIND=TRUE
clusters=(2 4 8 16 32 64 128 256 512)
threads=(2 4 8 16 32 64)
for t in ${threads[@]}
do
    for c in ${clusters[@]}
    do
        export OMP_NUM_THREADS=$t
        srun --export=ALL --cpus-per-task=$t ./parallel_openmp test_images/lake_4000_2667.png $c 10
    done
done
