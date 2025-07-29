#!/bin/bash
#FLUX: --job-name=PLUTO
#FLUX: --queue=qcpu
#FLUX: -t=1200
#FLUX: --urgency=16

source ${HOME}/modules_files/pluto_mod
cd ${HOME}/programming/gpluto_from_leo/Test_Problems/MHD/Orszag_Tang
for NN in 1; do            
    NG=$(( ${NN} * 128 ))                          
    mpirun -np ${NG} ./pluto -maxsteps 60         
    cp -v pluto.0.log plutolog_KAROcpu_${NN}          
done 
