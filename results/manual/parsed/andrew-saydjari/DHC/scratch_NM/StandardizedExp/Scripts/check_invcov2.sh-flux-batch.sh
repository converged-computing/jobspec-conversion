#!/bin/bash
#FLUX: --job-name=joyous-milkshake-7454
#FLUX: --priority=16

module load Julia/1.5.3-linux-x86_64
julia Check_Invcov_Logcoeff.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "checks" "Diagonal"
julia Check_Invcov_Logcoeff.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "checks" "Full"
julia Check_Invcov_Logcoeff.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "checks" "Diagonal+Eps"
julia Check_Invcov_Logcoeff.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "checks" "Full+Eps"
