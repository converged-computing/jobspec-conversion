#!/bin/bash
#FLUX: --job-name=job
#FLUX: --queue=rtx
#FLUX: -t=108000
#FLUX: --urgency=16

export CC='/opt/apps/gcc/8.3.0/bin/gcc'
export MONARCH_CONFIGS_PATH='${HOME}/maypaper/thesis/configurations/frontera/tf_placement_100g_disk.yaml'

ROOT_DIR="${HOME}/maypaper"
REPO="thesis"
WORKSPACE=$ROOT_DIR/$REPO
DATA="/scratch1/07854/dantas/shared"
LUSTRE_DATASET="${DATA}/imagenet_processed/100g_tfrecords"
TARGET_DIR="${ROOT_DIR}/results/tensorflow/june"
SERVER_CONFIGS="${WORKSPACE}/configurations/frontera/tf_controller_placement_100g_disk.yaml"
cd "${WORKSPACE}/tensorflow/scripts"
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
export MONARCH_CONFIGS_PATH="${HOME}/maypaper/thesis/configurations/frontera/tf_placement_100g_disk.yaml
for i in {1..4}; do
  RUN_DIR=$(${WORKSPACE}/common/get-run-dir.sh "lenet" $BATCH_SIZE $EPOCHS "${TARGET_DIR}/vanilla/lustre/monarch-comparison-100g")
  remora ./train.sh -m lenet -b $BATCH_SIZE -e $EPOCHS -g 4 -i autotune -l -v -d "$LUSTRE_DATASET" -r $RUN_DIR; echo "=> Completed disk lenet $LUSTRE_DATASET"
  sleep 10
  mv "remora_${SLURM_JOB_ID}"  $RUN_DIR
  #RUN_DIR=$(${WORKSPACE}/common/get-run-dir.sh "lenet" $BATCH_SIZE $EPOCHS "${TARGET_DIR}/caching/monarch-comparison")
  #remora ./train.sh -m lenet -b $BATCH_SIZE -e $EPOCHS -g 4 -i autotune -l -v -d "$LUSTRE_DATASET" -c "/tmp/tf-caching" -r $RUN_DIR; echo "=> Completed disk lenet $LUSTRE_DATASET"
  #sleep 10
  #mv "remora_${SLURM_JOB_ID}"  $RUN_DIR
  #rm /tmp/tf-caching*
  #RUN_DIR=$(${WORKSPACE}/common/get-run-dir.sh "lenet" $BATCH_SIZE $EPOCHS "${TARGET_DIR}/monarch/100g")
  #remora ./train.sh -m lenet -b $BATCH_SIZE -e $EPOCHS -g 4 -i autotune -x -l -v -d "$LUSTRE_DATASET" -r $RUN_DIR; echo "=> Completed disk lenet $LUSTRE_DATASET"
  #sleep 10
  #mv "remora_${SLURM_JOB_ID}"  $RUN_DIR
  #rm -r "/tmp/100g_tfrecords"
  RUN_DIR=$(${WORKSPACE}/common/get-run-dir.sh "alexnet" $BATCH_SIZE $EPOCHS "${TARGET_DIR}/vanilla/lustre/monarch-comparison-100g")
  remora ./train.sh -m alexnet -b $BATCH_SIZE -e $EPOCHS -g 4 -i autotune -l -v -d "$LUSTRE_DATASET" -r $RUN_DIR; echo "=> Completed disk alexnet $LUSTRE_DATASET"
  sleep 10
  mv "remora_${SLURM_JOB_ID}" $RUN_DIR
  #RUN_DIR=$(${WORKSPACE}/common/get-run-dir.sh "alexnet" $BATCH_SIZE $EPOCHS "${TARGET_DIR}/caching/monarch-comparison")
  #remora ./train.sh -m alexnet -b $BATCH_SIZE -e $EPOCHS -g 4 -i autotune -l -v -d "$LUSTRE_DATASET" -c "/tmp/tf-caching" -r $RUN_DIR; echo "=> Completed disk alexnet $LUSTRE_DATASET"
  #sleep 10
  #mv "remora_${SLURM_JOB_ID}"  $RUN_DIR
  #rm /tmp/tf-caching*
  #RUN_DIR=$(${WORKSPACE}/common/get-run-dir.sh "alexnet" $BATCH_SIZE $EPOCHS "${TARGET_DIR}/monarch/100g")
  #remora ./train.sh -m alexnet -b $BATCH_SIZE -e $EPOCHS -g 4 -i autotune -x -l -v -d "$LUSTRE_DATASET" -r $RUN_DIR; echo "=> Completed disk alexnet $LUSTRE_DATASET"
  #sleep 10
  #mv "remora_${SLURM_JOB_ID}" $RUN_DIR
  #rm -r "/tmp/100g_tfrecords"
  RUN_DIR=$(${WORKSPACE}/common/get-run-dir.sh "resnet" $BATCH_SIZE $EPOCHS "${TARGET_DIR}/vanilla/lustre/monarch-comparison-100g")
  remora ./train.sh -m resnet -b $BATCH_SIZE -e $EPOCHS -g 4 -i autotune -l -v -d "$LUSTRE_DATASET" -r $RUN_DIR; echo "=> Completed disk resnet $LUSTRE_DATASET"
  sleep 10  
  mv "remora_${SLURM_JOB_ID}" $RUN_DIR
  #RUN_DIR=$(${WORKSPACE}/common/get-run-dir.sh "resnet" $BATCH_SIZE $EPOCHS "${TARGET_DIR}/caching/monarch-comparison")
  #remora ./train.sh -m resnet -b $BATCH_SIZE -e $EPOCHS -g 4 -i autotune -l -v -d "$LUSTRE_DATASET" -c "/tmp/tf-caching" -r $RUN_DIR; echo "=> Completed disk resnet $LUSTRE_DATASET"
  #sleep 10  
  #mv "remora_${SLURM_JOB_ID}" $RUN_DIR
  #rm /tmp/tf-caching*
  #RUN_DIR=$(${WORKSPACE}/common/get-run-dir.sh "resnet" $BATCH_SIZE $EPOCHS "${TARGET_DIR}/monarch/100g")
  #remora ./train.sh -m resnet -b $BATCH_SIZE -e $EPOCHS -g 4 -i autotune -x -l -v -d "$LUSTRE_DATASET" -r $RUN_DIR; echo "=> Completed disk resnet $LUSTRE_DATASET"
  #sleep 10  
  #mv "remora_${SLURM_JOB_ID}" $RUN_DIR
  #rm -r "/tmp/100g_tfrecords"
done
