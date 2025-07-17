#!/bin/bash
#FLUX: --job-name=purple-kerfuffle-3762
#FLUX: -t=3600
#FLUX: --urgency=16

module load cuda/11.0.2
module load pgi/19.10
input=gpp214unformatted.dat
cd example-codes/GPP/
output=output
profilestr="ncu -k sigma_gpp_gpu -f -o $output --section-folder ../../ncu-section-files --section SpeedOfLight_HierarchicalDoubleRooflineChart "
echo Baseline version
git checkout gpp.f90
make clean
make
srun -n1 $profilestr ./gpp.x $input 
for n in `seq 1 4`
do
	output=output$n
	profilestr="ncu -k sigma_gpp_gpu -f -o $output --section-folder ../../ncu-section-files --section SpeedOfLight_HierarchicalDoubleRooflineChart "
	echo Patch version: $n
	git checkout gpp.f90
	patch gpp.f90 step$n.patch
	make clean
	make
	srun -n1 $profilestr ./gpp.x $input  
done
