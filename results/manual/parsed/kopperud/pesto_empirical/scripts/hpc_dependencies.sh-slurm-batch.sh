#!/bin/bash
#SBATCH --job-name=install_deps
#SBATCH --output=logs/dependencies.log
#SBATCH --error=logs/dependencies.err
#SBATCH --mail-user=b.kopperud@lmu.de
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8GB
#SBATCH --partition=krypton
#SBATCH --qos=high_prio

export R_HOME='/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R'
export LD_LIBRARY_PATH='/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R/lib'

module load R/4.3.2 gnu openblas
export R_HOME="/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R"
export LD_LIBRARY_PATH="/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R/lib"
julia scripts/setup/dependencies.jl > logs/jldep.txt
