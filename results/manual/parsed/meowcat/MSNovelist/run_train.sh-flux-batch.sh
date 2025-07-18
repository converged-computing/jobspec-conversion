#!/bin/bash
#FLUX: --job-name=tart-snack-5748
#FLUX: -n=4
#FLUX: -t=46799
#FLUX: --urgency=16

export COMPUTERNAME='EULER'

source .env
CMD=${1:-train}
CMD_EXEC=""
OPTS=""
case $CMD in
	"train")
		CMD_EXEC="python /msnovelist/train_mist.py"
		OPTS="--nv"
		FOLD=${SLURM_ARRAY_TASK_ID:-1}
		JOB=${SLURM_ARRAY_JOB_ID:-$SLURM_JOB_ID}
		;;
	"bash")
		CMD_EXEC="bash"
		OPTS=""
		;;
esac
if [[ "$CMD" == "train" ]]
then
	mkdir -p $RESULTS_LOC/train
	mkdir -p $RESULTS_LOC/weights
	echo "training_id: '$JOB'" > $RESULTS_LOC/train/$SLURM_JOB_ID.yaml
	echo "cv_fold: $FOLD" >> $RESULTS_LOC/train/$SLURM_JOB_ID.yaml
fi
echo "source _entrypoint.sh" >> $TMPDIR/.bashrc
rsync -ah --info=progress2 $DATA_LOC $TMPDIR
cp $DATA_LOC/*.yaml $TMPDIR
cp $CODE_LOC/*.yaml $TMPDIR
ls $TMPDIR
export COMPUTERNAME=EULER
singularity run \
	$OPTS \
	--bind $TMPDIR:/$HOME \
	--bind $TMPDIR:/sirius6_db \
	--bind $TMPDIR:/target \
	--bind $CODE_LOC:/msnovelist \
	--bind $RESULTS_LOC:/data \
	--bind $RESULTS_LOC:/msnovelist-data \
	$SIF_LOC \
	$CMD_EXEC
 #cd /msnovelist
 #export COMPUTERNAME=DOCKER-LIGHT
 #export MSNOVELIST_BASE=/msnovelist
 #export TF_CPP_MIN_LOG_LEVEL=3
 #python training_subclass.py -c /sirius6_db/config.yaml -c $DATA_LOC/train/$SLURM_JOB_ID.yaml
