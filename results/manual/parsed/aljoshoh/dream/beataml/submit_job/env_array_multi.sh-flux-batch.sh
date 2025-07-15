#!/bin/bash
#FLUX: --job-name=crusty-knife-1552
#FLUX: --urgency=16

BASEDIR=$1
TOTALTASKS=$2
FILE=$3
DOCKER=$5
tasksperarray=$6
TASKID=$SLURM_ARRAY_TASK_ID
SLEEPMULTIPLIER=10
echo $BASEDIR
echo Starting arrayscript job ...
echo USER: $USER
create_dir () {
	directory="$1"
	root="$2"
	if [ -d "$root/$directory" ]; then
		directory=$(($directory+1))
		directory=$(create_dir $directory $root)
	fi
	mkdir -p /localscratch/$USER/$directory
	echo $directory
}
dir=$(create_dir $TASKID /localscratch/$USER)
cd /localscratch/$USER/$dir
echo Created directory for local environment: $dir
ch-tar2dir /storage/groups/cbm01/tools/alexander.ohnmacht/r-studio-charliecloud-master-b76b94e8c5040cd58fb0ffd1a463fd7409bb886e/exports/$DOCKER.tar.gz /localscratch/$USER/$dir
echo Set up the docker image !
echo It is now:
date
echo
echo Running on machine
hostname
echo
echo Operating system
uname -r
sleep $(( TASKID * SLEEPMULTIPLIER ))
echo "Launching task Nr. $TASKID out of $TOTALTASKS !"
sleep $(( TASKID * SLEEPMULTIPLIER ))
for i in `seq 1 $tasksperarray`;
do
	echo Executing $BASEDIR/$FILE with option $i
	srun -n 1 ch-run -b /storage/groups/:/storage/groups/ /localscratch/$USER/$dir/$DOCKER/ -- Rscript $BASEDIR/$FILE $i $TASKID &
	sleep 5
done
wait
echo delete charlieclould image
srun rm -rf /localscratch/$USER/$dir/$DOCKER/
echo The job has ended.
