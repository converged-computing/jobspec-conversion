#!/bin/bash
#FLUX: --job-name=pts256CR76.000RaC80
#FLUX: -n=2
#FLUX: --queue=legacy
#FLUX: -t=604800
#FLUX: --urgency=16

python /run/preprocess/code.py
cd /network/group/aopp/oceans/AW002_PARKINSON_MUSH/optimalStates-restructured/Le200/CR76.000/RaC80/pts256-0; 
hs=$HOSTNAME 
if [[ $hs == *"gyre"* ]]; then 
	# I always forget to build the code on gyre, so adding a line here to make sure that's happened
 /home/parkinsonj/mushy-layer/execSubcycle/buildMushyLayer.sh; 
 # Run the code in paralle with 2 processors (gyre version)
 mpirun -np 2 /home/parkinsonj/mushy-layer/execSubcycle/mushyLayer2d.Linux.64.mpiCC.gfortran.OPT.MPI.GYRE.ex /network/group/aopp/oceans/AW002_PARKINSON_MUSH/optimalStates-restructured/Le200/CR76.000/RaC80/pts256-0/inputs 
else
 mpirun -np 2 /home/parkinsonj/mushy-layer/execSubcycle/mushyLayer2d.Linux.64.mpiCC.gfortran.OPT.MPI.ex /network/group/aopp/oceans/AW002_PARKINSON_MUSH/optimalStates-restructured/Le200/CR76.000/RaC80/pts256-0/inputs
fi
cd /home/parkinsonj/phd/; source env/bin/activate; python /home/parkinsonj/phd/python/analysis_postprocess/postProcessSingleFolder.py -R 80.000000 -C 76.000000 -P 256 -e 0 -r -a
