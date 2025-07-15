#!/bin/bash
#FLUX: --job-name=stanky-malarkey-2981
#FLUX: -n=4
#FLUX: -t=86399
#FLUX: --urgency=16

source .env
CMD=${1:-train}
CMD_EXEC=""
OPTS=""
case $CMD in
	"train")
		CMD_EXEC="/msnovelist/train.sh"
		OPTS="--nv"
		;;
	"bash")
		CMD_EXEC="bash"
		OPTS=""
		;;
esac
echo "training_id: '$SLURM_JOB_ID'" > $DATA_LOC/train/$SLURM_JOB_ID.yaml
if [[ "$SLURM_ARRAY_TASK_ID" != "" ]]
then
	echo "training_id: '$SLURM_ARRAY_JOB_ID'" > $DATA_LOC/train/$SLURM_JOB_ID.yaml
	echo "cv_fold: $SLURM_ARRAY_TASK_ID" >> $DATA_LOC/train/$SLURM_JOB_ID.yaml
fi
echo "source _entrypoint.sh" >> $TMPDIR/.bashrc
cp $DATA_LOC/*.db $TMPDIR
singularity run \
	$OPTS \
	--bind $TMPDIR:/$HOME \
	--bind $TMPDIR:/sirius6_db \
	--bind $DATA_LOC:/target \
	--bind $CODE_LOC:/msnovelist \
	--bind $DATA_LOC:/data \
	--bind $DATA_LOC:/msnovelist-data \
	$SIF_LOC \
	$CMD_EXEC
 #cd /msnovelist
 #export COMPUTERNAME=DOCKER-LIGHT
 #export MSNOVELIST_BASE=/msnovelist
 #export TF_CPP_MIN_LOG_LEVEL=3
 #python training_subclass.py -c /sirius6_db/config.yaml -c $DATA_LOC/train/$SLURM_JOB_ID.yaml
