#!/bin/bash
#FLUX: --job-name=dataset
#FLUX: -t=72000
#FLUX: --urgency=16

export PYTHONPATH='/opt/YARR/'
export XDG_RUNTIME_DIR='$SCRATCH/tmp/runtime-$SLURM_JOBID'

module purge
module load singularity
export PYTHONPATH=/opt/YARR/
export XDG_RUNTIME_DIR=$SCRATCH/tmp/runtime-$SLURM_JOBID
mkdir $XDG_RUNTIME_DIR
chmod 700 $XDG_RUNTIME_DIR
set -x
set -e 
checkpoints=${checkpoints:-checkpoints.txt}
checkpoint=$(sed -n "${SLURM_ARRAY_TASK_ID},${SLURM_ARRAY_TASK_ID}p" $checkpoints)
name=$(echo $checkpoint | cut -d '/' -f 2)
seed=${seed:-0}
num_episodes=${num_episodes:-100}
log_dir=$HOME/src/vln-robot/alhistory/logs
pwd; hostname; date
cd $HOME/src/vln-robot/alhistory/
srun --export=ALL,XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
	--cpus-per-task 1 \
	singularity exec --nv \
	--bind $WORK:$WORK,$SCRATCH:$SCRATCH,$STORE:$STORE,/gpfslocalsup:/gpfslocalsup/,/gpfslocalsys:/gpfslocalsys,/gpfs7kw:/gpfs7kw,/gpfsssd:/gpfsssd,/gpfsdsmnt:/gpfsdsmnt,/gpfsdsstore:/gpfsdsstore \
	$SINGULARITY_ALLOWED_DIR/vln-robot.sif \
	xvfb-run -a \
		-e $log_dir/${SLURM_JOBID}.out \
	/usr/bin/python3.9 $HOME/src/vln-robot/alhistory/eval.py \
		--seed $seed \
		--checkpoint $checkpoint \
		--name $prefix$name \
		--num_episodes $num_episodes \
		--headless \
		$args
