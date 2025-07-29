#!/bin/bash
#SBATCH --job-name=PipeFlow_%a
#SBATCH --account=scw1706
#SBATCH --error=PipeFlow.err.%a
#SBATCH --mail-user=2115589@swansea.ac.uk
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --time=00:00:10

module load compiler/gnu/12 mpi/openmpi/4.1.5 boost/1.82.0 fftw/3.3.10 cmake/3.14.3
source /apps/local/materials/OpenFOAM/v2212/el7/AVX512/gnu-12.1/openmpi-4.1/OpenFOAM-v2212/etc/bashrc
./Preproc
mpirun -np 40 chtMultiRegionSimpleFoam -parallel
./Postproc
