#!/bin/bash
#FLUX: --job-name=chunky-lemur-5210
#FLUX: --urgency=16

module load Julia/1.5.3-linux-x86_64
julia Check_Invcov_Logcoeff.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "checks" "Diagonal"
julia Check_Invcov_Logcoeff.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "checks" "Full"
julia Check_Invcov_Logcoeff.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "checks" "Diagonal+Eps"
julia Check_Invcov_Logcoeff.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "checks" "Full+Eps"
