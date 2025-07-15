#!/bin/bash
#FLUX: --job-name=lj
#FLUX: -N=4
#FLUX: --queue=queue-1
#FLUX: --priority=16

export PATH='/shared/tools/openmpi-4.1.5-arml/bin:$PATH'
export LD_LIBRARY_PATH='/shared/tools/openmpi-4.1.5-arml/lib:$LD_LIBRARY_PATH'
export OMPI_MCA_mtl_base_verbose='1'
export NX='32'
export NY='32'
export NZ='32'
export LAMMPS_EXE='/shared/tools/lammps/armpl-sve/lmp_aarch64_arm_openmpi_armpl'
export MPIRUN='/shared/tools/openmpi-4.1.5-arml/bin/mpirun'
export OMP_NUM_THREADS='2'

module use /shared/arm/modulefiles
module load acfl/23.04.1
module load armpl/23.04.1
module load libfabric-aws/1.17.1
export PATH=/shared/tools/openmpi-4.1.5-arml/bin:$PATH
export LD_LIBRARY_PATH=/shared/tools/openmpi-4.1.5-arml/lib:$LD_LIBRARY_PATH
export OMPI_MCA_mtl_base_verbose=1
export NX=32
export NY=32
export NZ=32
export LAMMPS_EXE="/shared/tools/lammps/armpl-sve/lmp_aarch64_arm_openmpi_armpl"
export MPIRUN="/shared/tools/openmpi-4.1.5-arml/bin/mpirun"
curl -o in.lj "https://www.lammps.org/inputs/in.lj.txt"
export OMP_NUM_THREADS=2
$MPIRUN -np 128 --map-by ppr:32:node $LAMMPS_EXE -sf omp -var x $NX -var y $NY -var z $NZ -in in.lj
