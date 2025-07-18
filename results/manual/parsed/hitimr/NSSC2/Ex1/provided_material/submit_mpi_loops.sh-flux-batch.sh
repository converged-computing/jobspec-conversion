#!/bin/bash
#FLUX: --job-name=jacobiMPI
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: -t=3600
#FLUX: --urgency=16

if command -v sinfo  2>/dev/null # if on cluster
then
    module load mpi/openmpi-x86_64
    module load pmi/pmix-x86_64
    mpiprocs=( 1 2 5 10 20 40 80)
    folder="datacluster"
    mkdir -p $folder    
else  # if on local machine
    folder="datalocal"
    mkdir -p $folder    
    mpiprocs=( 1 2 )
fi
iterations=10
resolutions=( 125 250 )
for resolution in "${resolutions[@]}"
do  
    for procs in "${mpiprocs[@]}"
    do  
        mpirun -n $procs ./jacobiMPI $resolution $iterations |& tee "./${folder}/jacobiMPI_${resolution}_${iterations}_n_${procs}.log"
    done
done
