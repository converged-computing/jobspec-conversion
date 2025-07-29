#!/bin/bash
#SBATCH --job-name=jobname
#SBATCH --output=output.log
#SBATCH --mail-user=<email>@email.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100
#SBATCH --time=00:05:00

set -u # fail when using an undefined variable
set -x # echo script lines as they are executedi
set -e # abort at first error
module load Python/3.7.4-GCCcore-8.3.0
module load h5py/2.10.0-intel-2019b-Python-3.7.4
module load netcdf4-python/1.5.3-intel-2019b-Python-3.7.4
srun ./myprogram.sh
exit
