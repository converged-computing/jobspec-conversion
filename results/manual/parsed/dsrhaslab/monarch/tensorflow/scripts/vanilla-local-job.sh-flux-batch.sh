#!/bin/bash
#FLUX: --job-name=job
#FLUX: --queue=rtx
#FLUX: -t=86400
#FLUX: --urgency=16

export CC='/opt/apps/gcc/8.3.0/bin/gcc'

ROOT_DIR="${HOME}/maypaper"
REPO="thesis"
DATA="/scratch1/07854/dantas/shared"
WORKSPACE=$ROOT_DIR/$REPO
LOCAL_DATASET="/tmp/100g_tfrecords"
TARGET_DIR="${ROOT_DIR}/results/tensorflow/june/vanilla/local"
cd "${WORKSPACE}/tensorflow/scripts"
unzip "${DATA}/imagenet_processed/100g_tfrecords.zip" -d /tmp
echo "cp ${DATA}/objects/44g.zip /dev/shm"
cp "${DATA}/objects/44g.zip" /dev/shm
echo "cp ${DATA}/objects/7g.zip /dev/shm"
cp "${DATA}/objects/7g.zip" /dev/shm
echo "cp ${DATA}/objects/6g.zip /dev/shm"
cp "${DATA}/objects/6g.zip" /dev/shm
echo "cp ${DATA}/objects/3g /dev/shm"
cp "${DATA}/objects/3g" /dev/shm
echo "module load remora"
module load remora
echo "module load gcc/8.3.0"
export CC="/opt/apps/gcc/8.3.0/bin/gcc"
echo "module load cuda/10.1/10.1.243 cudnn/7.6/7.6.5 nccl/2.4/2.4.8-1 openmpi/2.1.6"
module load cuda/10.1
module load cudnn/7.6.5
module load nccl/2.5.6
EPOCHS=3
BATCH_SIZE=256
for i in {1..3}; do
    RUN_DIR=$(${WORKSPACE}/common/get-run-dir.sh "lenet" $BATCH_SIZE $EPOCHS $TARGET_DIR)
    remora ./train.sh -m lenet -b $BATCH_SIZE -e $EPOCHS -g 4 -i autotune -l -v -d $LOCAL_DATASET -r $RUN_DIR
    sleep 10
    mv remora* $RUN_DIR
    RUN_DIR=$(${WORKSPACE}/common/get-run-dir.sh "alexnet" $BATCH_SIZE $EPOCHS $TARGET_DIR)
    remora ./train.sh -m alexnet -b $BATCH_SIZE -e $EPOCHS -g 4 -i autotune -l -v -d $LOCAL_DATASET -r $RUN_DIR
    sleep 10
    mv remora* $RUN_DIR
    RUN_DIR=$(${WORKSPACE}/common/get-run-dir.sh "resnet" $BATCH_SIZE $EPOCHS $TARGET_DIR)
    remora ./train.sh -m resnet -b $BATCH_SIZE -e $EPOCHS -g 4 -i autotune -l -v -d $LOCAL_DATASET -r $RUN_DIR
    sleep 10
    mv remora* $RUN_DIR
done
