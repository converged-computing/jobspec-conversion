#!/bin/bash
#FLUX: --job-name=bcd_icassp23
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --urgency=16

export SLURM_SUBMIT_DIR='/home/users/yalan/binary_seq_opt/icassp23'
export GUROBI_HOME='/share/software/user/restricted/gurobi/9.0.3_py36'

module load julia
module load gurobi
export SLURM_SUBMIT_DIR=/home/users/yalan/binary_seq_opt/icassp23
cd $SLURM_SUBMIT_DIR
export GUROBI_HOME="/share/software/user/restricted/gurobi/9.0.3_py36"
lscpu
julia icassp23.jl 0 "" 64 4 1 SOS false 100000 256 true
julia icassp23.jl 1 "" 64 4 1 SOS false 100000 256 true
julia icassp23.jl 2 "" 64 4 1 SOS false 100000 256 true
julia icassp23.jl 3 "" 64 4 1 SOS false 100000 256 true
julia icassp23.jl 4 "" 64 4 1 SOS false 100000 256 true
julia icassp23.jl 5 "" 64 4 1 SOS false 100000 256 true
julia icassp23.jl 6 "" 64 4 1 SOS false 100000 256 true
julia icassp23.jl 7 "" 64 4 1 SOS false 100000 256 true
julia icassp23.jl 8 "" 64 4 1 SOS false 100000 256 true
julia icassp23.jl 9 "" 64 4 1 SOS false 100000 256 true
