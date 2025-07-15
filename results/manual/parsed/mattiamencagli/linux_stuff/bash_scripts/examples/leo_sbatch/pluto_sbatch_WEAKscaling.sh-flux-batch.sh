#!/bin/bash
#FLUX: --job-name=PLUTO_sW
#FLUX: -N=32
#FLUX: --queue=boost_usr_prod
#FLUX: -t=3600
#FLUX: --urgency=16

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
