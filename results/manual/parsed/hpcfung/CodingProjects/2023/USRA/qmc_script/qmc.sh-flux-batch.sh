#!/bin/bash
#FLUX: --job-name=qmc_units_test
#FLUX: -c=2
#FLUX: -t=600
#FLUX: --priority=16

module purge
module load julia/1.8.5 StdEnv/2020
julia rydberg_bloqade_ver.jl thermal 16 /home/hpcfung/qmc_test --omega 26.6407057024 --delta -1.545 --radius 1.15 --rand-slice --restart
echo 'qmc program completed'
