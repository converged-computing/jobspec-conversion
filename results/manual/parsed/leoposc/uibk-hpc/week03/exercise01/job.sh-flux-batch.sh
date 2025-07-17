#!/bin/bash
#FLUX: --job-name=test
#FLUX: -n=96
#FLUX: --exclusive
#FLUX: --queue=lva
#FLUX: --urgency=16

ns=(192 288 384 480 576 672 768)
rs=(16 32 96)
module purge
module load openmpi/3.1.6-gcc-12.2.0-d2gmn55
for n in "${ns[@]}"
do
    for r in "${rs[@]}"
    do
        echo "executing mpi-$n-$r"
        sbatch --wait ./mpi-job-script.slurm $n $r
    done
done
