#!/bin/bash
#SBATCH --job-name=257cd_eurasip
#SBATCH --output=257cd_eurasip_e%j.txt
#SBATCH --error=FAILURE_257cd_eurasip_257_e%j.txt
#SBATCH --mail-user=yalan@stanford.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=2-00:00:00
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=1

export SLURM_SUBMIT_DIR='/home/groups/gracegao/prn_codes/binary_seq_opt/eurasip'
export GUROBI_HOME='/share/software/user/restricted/gurobi/9.0.3_py36'

module load julia
module load gurobi
export SLURM_SUBMIT_DIR=/home/groups/gracegao/prn_codes/binary_seq_opt/eurasip
cd $SLURM_SUBMIT_DIR
export GUROBI_HOME="/share/software/user/restricted/gurobi/9.0.3_py36"
lscpu
julia --heap-size-hint=4G eurasip.jl 0 "" 257 130 1 ACZSOS true 1000000 1000000 true 130 1 100
