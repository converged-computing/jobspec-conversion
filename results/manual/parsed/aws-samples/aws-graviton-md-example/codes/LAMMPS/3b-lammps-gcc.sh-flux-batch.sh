#!/bin/bash
#FLUX: --job-name=lj
#FLUX: -N=4
#FLUX: --queue=queue-1
#FLUX: --urgency=16

export OMPI_MCA_mtl_base_verbose='1'
export NX='32'
export NY='32'
export NZ='32'
export LAMMPS_EXE='/shared/tools/lammps/armpl-sve/lmp_aarch64_g++_openmpi_armpl_O3_mpcu_march_native_omp'
export OMP_NUM_THREADS='2'

module use /shared/arm/modulefiles
module load gnu/12.2.0
module load openmpi/4.1.5
module load libfabric-aws/1.17.1
module load armpl/23.04.1
export OMPI_MCA_mtl_base_verbose=1
export NX=32
export NY=32
export NZ=32
export LAMMPS_EXE="/shared/tools/lammps/armpl-sve/lmp_aarch64_g++_openmpi_armpl_O3_mpcu_march_native_omp"
MPIRUN=$(which mpirun)
curl -o in.lj "https://www.lammps.org/inputs/in.lj.txt"
export OMP_NUM_THREADS=2
$MPIRUN -np 128 --map-by ppr:32:node $LAMMPS_EXE -sf omp -var x $NX -var y $NY -var z $NZ -in in.lj
