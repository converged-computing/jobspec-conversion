#!/bin/bash
#SBATCH --job-name=up_vs_down_joint
#SBATCH --output=logs/up_vs_down_joint.log
#SBATCH --error=logs/up_vs_down_joint.err
#SBATCH --mail-user=b.kopperud@lmu.de
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=4GB
#SBATCH --partition=krypton
#SBATCH --qos=low_prio_res

export R_HOME='/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R'
export LD_LIBRARY_PATH='/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R/lib'

module load R/4.3.2 gnu openblas
export R_HOME="/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R"
export LD_LIBRARY_PATH="/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R/lib"
julia --threads ${SLURM_CPUS_PER_TASK} scripts/up_vs_down_inference_joint.jl > logs/up_vs_down_joint.txt
