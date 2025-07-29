#!/bin/bash
#SBATCH --job-name=87.2.7
#SBATCH --account=pn49ye
#SBATCH --output=./%x.%j.out
#SBATCH --error=./%x.%j.err
#SBATCH --mail-user=ryanjsfx@mpa-garching.mpg.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=00:29:50
#SBATCH --chdir=./
#SBATCH --no-requeue

module load spack/22.2.1
module load intel-oneapi-toolkit/2022.3.0
module load hdf5/1.8.22-intel21-impi
module list
echo "PWD: $PWD"
date
srun ./athena -i ../tst/megKH/athinputmeg.kh
date
