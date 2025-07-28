#!/bin/bash
#FLUX: --job-name=SpackBuilds
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --urgency=16

if [ -z "${SLURM_CPUS_PER_TASK}" ]
then 
	CORECOUNT=4
else
	CORECOUNT=${SLURM_CPUS_PER_TASK} #grab the core count from slurm task
fi
ARCH="x86_64" #this is the main target, select either x86_64, zen2, or skylake_avx512
BASE_GCC_VERS=5.5.0 #the version of gcc that will be used to build other variations of gcc 
compilers=(
    %gcc@13.1.0
)
mpis=(
    openmpi
    mpich
)
git clone -c feature.manyFiles=true https://github.com/spack/spack.git
mv spack/etc/spack/defaults/packages.yaml spack/etc/spack/defaults/packages.yaml_bak
mv spack/etc/spack/defaults/modules.yaml spack/etc/spack/defaults/modules.yaml_bak
cp defaults/modules.yaml spack/etc/spack/defaults/modules.yaml
cp defaults/packages.yaml spack/etc/spack/defaults/packages.yaml
source spack/share/spack/setup-env.sh
spack install -j${CORECOUNT} gcc@${BASE_GCC_VERS} target=x86_64
spack compiler find `spack location --install-dir gcc@${BASE_GCC_VERS}`
spack compiler find `spack location --install-dir gcc@${BASE_GCC_VERS}`/bin
for compiler in "${compilers[@]}"
do
    # Serial installs
    spack install -j${CORECOUNT} proj $compiler target=${ARCH}
    spack install -j${CORECOUNT} swig $compiler target=${ARCH}
    spack install -j${CORECOUNT} maven $compiler target=${ARCH}
    spack install -j${CORECOUNT} geos $compiler target=${ARCH}
    # Parallel installs
    for mpi in "${mpis[@]}"
    do
        spack install -j${CORECOUNT} $mpi $compiler target=${ARCH}
        spack install -j${CORECOUNT} cdo  $compiler ^$mpi target=${ARCH}
        spack install -j${CORECOUNT} parallel-netcdf $compiler ^$mpi target=${ARCH}
        spack install -j${CORECOUNT} petsc $compiler ^$mpi target=${ARCH}
		spack install -j${CORECOUNT} netcdf-fortran $compiler ^$mpi target=${ARCH}
		spack install -j${CORECOUNT} netcdf-c $compiler ^$mpi target=${ARCH}
		spack install -j${CORECOUNT} netcdf-cxx4 $compiler ^$mpi target=${ARCH}
		spack install -j${CORECOUNT} hdf5 $compiler ^$mpi target=${ARCH}
		spack install -j${CORECOUNT} fftw $compiler ^$mpi target=${ARCH}
		spack install -j${CORECOUNT} parallelio $compiler ^$mpi target=${ARCH}
		spack install -j${CORECOUNT} dealii $compiler ^$mpi target=${ARCH}
		spack install -j${CORECOUNT} cgal $compiler ^$mpi target=${ARCH}
    done
done
spack module lmod refresh --delete-tree -y
exit 0
