#!/bin/bash
#FLUX: --job-name=grated-leader-3305
#FLUX: --urgency=16

module load xfdtd/7.10.2.3 #7.9.2.2
module load cuda
source  $WorkingDir/Run_Outputs/$RunName/setup.sh
symmetry_multiplier=2
if [ $SYMMETRY -eq 1 ]
then
	symmetry_multiplier=1
fi
sim_num=$SLURM_ARRAY_TASK_ID
indiv_in_pop=$((sim_num-1))
if [ $SingleBatch -eq 1 ]
then
	upper_limit=$((NPOP*symmetry_multiplier-1))
else
	upper_limit=$indiv_in_pop
fi
while [ $indiv_in_pop -le $upper_limit ]
do
	# Get the Individuals's Simulation Directory
	individual_number=$((gen*NPOP*symmetry_multiplier+sim_num))
	indiv_dir_parent=$XFProj/Simulations/$(printf "%06d" $individual_number)
	indiv_dir=$indiv_dir_parent/Run0001
	# Run The xsolver
	cd $indiv_dir
	xfsolver --use-xstream=true --xstream-use-number=2 --num-threads=2 -v
	echo "finished XF solver"
	# Create a flag file to indicate that the GPU job is done
	cd $RunDir/Flags/TMPGPUFlags
	flag_file=Part_B_GPU_Flag_${individual_number}.txt
	echo "The GPU job is done!" >> $flag_file
	# iterate which individual we're on
	sim_num=$((indiv_in_pop+batch_size*symmetry_multiplier))
	indiv_in_pop=$((sim_num-1))
	# if we go over target, the job doesn't need to wait for
	# output xmacro and can terminate
	if [ $indiv_in_pop -gt $upper_limit ]
	then
		# echo how long this bash script has been running
		echo $SECONDS
		# echo all job information about time
		sacct -X -j $SLURM_JOB_ID --format=JobID,JobName,Partition,Elapsed,CPUTime,Reserved
		exit 0
	fi
	# wait until output xmacro is finished before starting next xsolver
	# to not go over XF key limit
	while [ ! -f $RunDir/Flags/GPUFlags/$flag_file ]
	do
		sleep 1
	done
done
echo $SECONDS
sacct -X -j $SLURM_JOB_ID --format=JobID,JobName,Partition,Elapsed,CPUTime,Reserved
