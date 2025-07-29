#!/bin/bash
#FLUX: --job-name=lap_opm
#FLUX: -c=96
#FLUX: --queue=fast
#FLUX: -t=5400
#FLUX: --urgency=16

    lscpu
    echo "    "
    echo "*** SEQUENTIAL ***"
    srun singularity run container.sif laplace_seq 2048
    for j in {1,2,5,10,20,40,64};
        do
            export OMP_NUM_THREADS=$j
            echo "*** OPENMP COM $j THREADS ***"
            srun singularity run container.sif laplace_omp 2048
            echo "    "
            echo "*** OPENMP COLLAPSE COM $j THREADS ***"
            srun singularity run container.sif laplace_omp_collapse 2048
            echo "    "
        done
    echo "    "
