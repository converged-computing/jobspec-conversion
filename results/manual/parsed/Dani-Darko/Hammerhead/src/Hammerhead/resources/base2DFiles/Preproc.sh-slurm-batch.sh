#!/bin/bash
#SBATCH --job-name=PipeFlow_%a
#SBATCH --account=scw1706
#SBATCH --error=PipeFlow.err.%a
#SBATCH --mail-user=2115589@swansea.ac.uk
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=00:00:01

cd /lustrehome/home/s.2115589/caseDatabase/
module load compiler/intel/2018/4\ mpi/intel/2018/4\ boost/1.69.0\ cmake/3.14.3\ fftw/3.3.8
source /apps/local/materials/OpenFOAM/v2106/el7/AVX512/intel-2018/intel-2018/OpenFOAM-v2106/etc/bashrc
./Preproc
