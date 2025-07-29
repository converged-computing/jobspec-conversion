#!/bin/bash
#SBATCH --job-name=ISO
#SBATCH --output=./sbatch.o%j
#SBATCH --error=./sbatch.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=batch

export PMIX_MCA_gds='hash'
export LD_LIBRARY_PATH='\$LD_LIBRARY_PATH:${HOME}/local/lib64'

ulimit -s unlimited
ulimit -c unlimited
ulimit -v unlimited
export PMIX_MCA_gds=hash
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:${HOME}/local/lib64
cd $PWD
module load python-3.9.15-gcc-9.4.0-f466wuv
source .venv/bin/activate
./test.sh
