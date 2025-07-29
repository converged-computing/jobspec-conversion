#!/bin/bash
#SBATCH --job-name=PLUTO_sW
#SBATCH --account=cin_staff
#SBATCH --mail-user=m.mencagli@cineca.it
#SBATCH --mail-type=NONE
#SBATCH --nodes=32
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=32

source ${HOME}/modules_files/pluto_mod 23.11
cd ${HOME}/programming/gpluto_cpp/Test_Problems/MHD/Orszag_Tang
pwd
make -j -B > makeout 2>&1
for NN in 32; do 
	NG=$(( ${NN} * 32 ))
	cp -v pluto_${NN}.ini pluto.ini
	mpirun -np ${NG} ./pluto -maxsteps 40
	cp -v pluto.0.log /leonardo_scratch/large/userinternal/mmencag1/WEAK_test_GPUs/plutologWEAK_cpu_${NN}
done
