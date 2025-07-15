#!/bin/bash
#FLUX: --job-name=boopy-rabbit-4949
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --urgency=16

export PYTHONPATH='$STEPS_INSTALL_DIR:$PYTHONPATH'
export STEPS_INSTRUMENTOR_MPI_BARRIER='before;after'

export PYTHONPATH="$STEPS_INSTALL_DIR:$PYTHONPATH"
module purge
module load archive/2021-12 git cmake python/3.8.3 gcc boost
module unload hpe-mpi
module load likwid/5.2.0
spack load mpich@3.3.2
spack load petsc@3.14.1
spack load gmsh@4.4.1
spack load caliper@2.6.0
echo "*****"
echo ${NTASKS}
echo $((NTASKS / 2))
echo "*****"
export STEPS_INSTRUMENTOR_MPI_BARRIER="before;after"
time likwid-mpirun -d -np ${NTASKS} -nperdomain S:$((NTASKS / 2)) -m -g MEM_DP \
python3 caBurstFullModel.py 1 ../../../mesh/split_${NTASKS}/steps4/CNG_segmented_2_split_${NTASKS} 1
