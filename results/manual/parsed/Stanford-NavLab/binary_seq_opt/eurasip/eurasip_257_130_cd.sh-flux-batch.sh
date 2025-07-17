#!/bin/bash
#FLUX: --job-name=257cd_eurasip
#FLUX: -c=4
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --urgency=16

export SLURM_SUBMIT_DIR='/home/groups/gracegao/prn_codes/binary_seq_opt/eurasip'
export GUROBI_HOME='/share/software/user/restricted/gurobi/9.0.3_py36'

module load julia
module load gurobi
export SLURM_SUBMIT_DIR=/home/groups/gracegao/prn_codes/binary_seq_opt/eurasip
cd $SLURM_SUBMIT_DIR
export GUROBI_HOME="/share/software/user/restricted/gurobi/9.0.3_py36"
lscpu
julia --heap-size-hint=4G eurasip.jl 0 "" 257 130 1 ACZSOS true 1000000 1000000 true 130 1 100
