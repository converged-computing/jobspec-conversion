#!/bin/bash
#FLUX: --job-name=dirty-peanut-butter-1047
#FLUX: --urgency=16

cd $WorkingDir
cd Run_Outputs/$RunName/GPUFlags
module load xfdtd/7.9.2.2
module load cuda
individual_number=$((${gen}*${NPOP}+${SLURM_ARRAY_TASK_ID}))
if [ $individual_number -lt 10 ]
then
	indiv_dir_parent=$XFProj/Simulations/00000$individual_number/
elif [[ $individual_number -ge 10 && $individual_number -lt 100 ]]
then
	indiv_dir_parent=$XFProj/Simulations/0000$individual_number/
elif [[ $individual_number -ge 100 && $individual_number -lt 1000 ]]
then
	indiv_dir_parent=$XFProj/Simulations/000$individual_number/
elif [ $individual_number -ge 1000 ]
then
	indiv_dir_parent=$XFProj/Simulations/00$individual_number/
fi
indiv_dir=$indiv_dir_parent/Run0001
cd $indiv_dir
xfsolver --use-xstream=true --xstream-use-number=2 --num-threads=2 -v
cd $WorkingDir/Run_Outputs/$RunName/GPUFlags
echo "The GPU job is done!" >> Part_B_GPU_Flag_${individual_number}.txt 
