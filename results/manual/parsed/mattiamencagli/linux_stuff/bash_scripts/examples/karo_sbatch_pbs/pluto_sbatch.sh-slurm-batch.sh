#!/bin/bash
#SBATCH --job-name=PLUTO
#SBATCH --account=FTA-23-25
#SBATCH --mail-user=m.mencagli@cineca.it
#SBATCH --mail-type=NONE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=qcpu
#SBATCH --constraint=ntasks-per-node=128

source ${HOME}/modules_files/pluto_mod
cd ${HOME}/programming/gpluto_from_leo/Test_Problems/MHD/Orszag_Tang
for NN in 1; do            
    NG=$(( ${NN} * 128 ))                          
    mpirun -np ${NG} ./pluto -maxsteps 60         
    cp -v pluto.0.log plutolog_KAROcpu_${NN}          
done 
