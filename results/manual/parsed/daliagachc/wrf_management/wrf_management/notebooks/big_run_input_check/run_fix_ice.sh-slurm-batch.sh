#!/bin/bash
#SBATCH --output=./output%j.txt
#SBATCH --error=./error%j.txt
#SBATCH --mail-user=diego.aliaga@helsinki.fi
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=00:20:00

export NETCDF='/appl/opt/netcdf4/gcc-7.3.0/intelmpi-18.0.2/4.6.1/'
export WRFIO_NCD_LARGE_FILE_SUPPORT='1'

export NETCDF=/appl/opt/netcdf4/gcc-7.3.0/intelmpi-18.0.2/4.6.1/
module purge
module load gcc/7.3.0  intelmpi/18.0.2 hdf5-par/1.8.20 netcdf4/4.6.1
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
conda activate b36
srun jupyter nbconvert --ExecutePreprocessor.timeout=600 --execute --to notebook --inplace check_lowinp_02.ipynb
