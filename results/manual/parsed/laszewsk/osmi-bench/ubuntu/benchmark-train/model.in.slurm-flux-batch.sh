#!/bin/bash
#FLUX: --job-name={identifier}
#FLUX: --queue=batch
#FLUX: --urgency=16

{slurm.sbatch}
PROGRESS() {
echo "# ###############################################"
echo "# cloudmesh status=$1 progress=$2 msg=$3 pid=$$"
echo "# ###############################################"
}
VENV=ENV3-OSMI
USER_NAME=`whoami`
GROUP_NAME=`id -g`
USER_ID=`id -u`
GROUP_ID=`getent group | fgrep ${GROUP_NAME} | cut -d":" -f 3`
PROGRESS "running" "modules" 1
if echo "$hostname" | grep -q "crusher"; then
echo "Module load on 'crusher'"
source /opt/cray/pe/cpe/23.12/restore_lmod_system_defaults.sh
module load cray-python
module load rocm
module list
WITH_CONTAINER="NONE"
elif echo "$hostname" | grep -q "summit"; then
echo "Module load on 'summit'"
module load open-ce/1.1.3-py38-0
module load cuda/11.0.2
WITH_CONTAINER="NONE"
else
echo "Regular Linux machine. No module load"
CONTAINER_DIR=../../../../images
fi
PROGRESS "running" "python" 1
source ../../../$VENV/bin/activate
which python
python --version
python ../../../test-tf.py
PROGRESS "running" "gpus" 1
if echo "$hostname" | grep -q "crusher"; then
rocm-smi
else
nvidia-smi
fi
MODELS_DIR=./models
RESULT_DIR=`pwd`
MODEL={experiment.model}
CONTAINER=$CONTAINER_DIR/cloudmesh-tfs-23-10-nv.sif
echo "============================================================"
echo "PROJECT_ID: {identifier}"
echo "MODELS_DIR: $MODELS_DIR"
echo "MODEL: $MODEL"
echo "REPEAT: {experiment.repeat}"
PROGRESS "running" "training" 3
cd $MODELS_DIR
if [ "$WITH_CONTAINER" = "apptainer" ]; then
time apptainer exec --nv $CONTAINER python train.py $MODEL 2>&1 | tr -d '\033\b' | tee $RESULT_DIR/train.log
elif [ "$WITH_CONTAINER" = "docker" ]; then
docker run -it \
-v /home/${USER}:/home/${USER} \
-v ${PWD}:${PWD} \
-u ${USER_ID}:${GROUP_NAME} \
-w ${PWD} \
--gpus all \
--volume="/etc/group:/etc/group:ro" \
--volume="/etc/passwd:/etc/passwd:ro" \
--volume="/etc/shadow:/etc/shadow:ro" \
osmi.docker /bin/bash -c "cd ${PWD}; python train.py $MODEL"
else
time python train.py $MODEL 2>&1 | tr -d '\033\b' | tee $RESULT_DIR/train.log
fi
PROGRESS "completed" "done" 100
