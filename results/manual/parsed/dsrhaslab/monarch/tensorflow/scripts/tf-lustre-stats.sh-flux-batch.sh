#!/bin/bash
#FLUX: --job-name=bumfuzzled-underoos-7007
#FLUX: --priority=16

export CC='/opt/apps/gcc/8.3.0/bin/gcc'
export MONARCH_CONFIGS_PATH='${HOME}/maypaper/thesis/configurations/frontera/tf_placement_200g_disk.yaml'

ROOT_DIR="${HOME}/maypaper"
REPO="thesis"
WORKSPACE=$ROOT_DIR/$REPO
DATA="/scratch1/07854/dantas/shared"
echo "cp ${DATA}/objects/44g.zip /dev/shm"
cp "${DATA}/objects/44g.zip" /dev/shm
echo "cp ${DATA}/objects/7g.zip /dev/shm"
cp "${DATA}/objects/7g.zip" /dev/shm
echo "cp ${DATA}/objects/6g.zip /dev/shm"
cp "${DATA}/objects/6g.zip" /dev/shm
echo "cp ${DATA}/objects/3g /dev/shm"
cp "${DATA}/objects/3g" /dev/shm
echo "Loading gcc and python modules"
export CC="/opt/apps/gcc/8.3.0/bin/gcc"
echo "module load cuda/10.1/10.1.243 cudnn/7.6/7.6.5 nccl/2.4/2.4.8-1 openmpi/2.1.6"
module load cuda/10.1
module load cudnn/7.6.5
module load nccl/2.5.6
echo "module load remora"
module load remora
cd "${WORKSPACE}/tensorflow/scripts"
EPOCHS=3
BATCH_SIZE=256
TARGET_DIR="${ROOT_DIR}/results/lustre-iops/tensorflow"
DATASET="${DATA}/imagenet_processed/100g_tfrecords"
export MONARCH_CONFIGS_PATH="${HOME}/maypaper/thesis/configurations/frontera/tf_placement_100g_disk.yaml"
for i in {1..1}; do
  RUN_DIR=$(${WORKSPACE}/common/get-run-dir.sh "lenet" $BATCH_SIZE $EPOCHS "${TARGET_DIR}/monarch/100g")
  remora ./train.sh -o -m lenet -b $BATCH_SIZE -e $EPOCHS -g 4 -i autotune -x -l -v -d "$DATASET" -r $RUN_DIR
  sleep 10
  rm -r "/tmp/100g_tfrecords"
  mv "remora_${SLURM_JOB_ID}"  $RUN_DIR
done
DATASET="${DATA}/imagenet_processed/200g_2048_tfrecords"
export MONARCH_CONFIGS_PATH="${HOME}/maypaper/thesis/configurations/frontera/tf_placement_200g_disk.yaml"
