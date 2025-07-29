#!/bin/bash
#SBATCH --job-name=hello
#SBATCH --account=ccsd
#SBATCH --output=./hello.o
#SBATCH --error=./hello.e
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0
#SBATCH --time=00:00:10
#SBATCH --partition=batch
#SBATCH --constraint=ntasks-per-node=4

export MODULEPATH='/software/cades-open/spack-envs/base/modules/site/Core:/software/cades-open/modulefiles/core'

cd ~/R4HPC/code_1
pwd
source /software/cades-open/spack-envs/base/root/linux-centos7-x86_64/gcc-6.3.0/lmod-8.5.6-wdngv4jylfvg2j6jt7xrtugxggh5lpm5/lmod/lmod/init/bash
export MODULEPATH=/software/cades-open/spack-envs/base/modules/site/Core:/software/cades-open/modulefiles/core
module load gcc
module load openmpi
module load r/4.1.0-py3-X-flexiblas 
echo "loaded R with flexiblas"
module list
mpirun --map-by ppr:4:node Rscript hello_balance.R
