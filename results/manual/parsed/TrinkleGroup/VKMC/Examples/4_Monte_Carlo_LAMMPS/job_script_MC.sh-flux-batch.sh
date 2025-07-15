#!/bin/bash
#FLUX: --job-name=MyJob
#FLUX: --queue=cpu
#FLUX: -t=86400
#FLUX: --urgency=16

VKMC=/path/to/the/local/copy/of/the/VKMC/repository # We Need to add the full path to the local copy of the VKMC respository here.
potpath=$VKMC/Utils/pot
LMP_MC=$VKMC/Utils/MEAM_MC
T=1073
jobID=1 # or 2 or 3 or 4 or 5 depending on which simulation is being done.
mkdir ${T}_${jobID}
for i in {1..40}
do
	mkdir ${T}_${jobID}/${T}_${jobID}_${i} # This is the directory in which all run results will be stored.
	cd ${T}_${jobID}/${T}_${jobID}_${i}
	python -u $LMP_MC/Init_state_MC.py -pp $potpath -T $T -etol 0.0 -ftol 0.001 -na 99 100 100 100 100 -nt 120000 -ne 250 -ns 250 -dmp -dpf args_continue_${i}.txt > JobOut_${i}.txt 2>&1 &
	cd ../../
done
wait
