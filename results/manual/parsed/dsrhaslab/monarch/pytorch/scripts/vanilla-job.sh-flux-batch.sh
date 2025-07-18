#!/bin/bash
#FLUX: --job-name=job
#FLUX: --queue=rtx
#FLUX: -t=172800
#FLUX: --urgency=16

export CC='/opt/apps/gcc/8.3.0/bin/gcc'

ROOT_DIR="${HOME}/maypaper"
REPO="thesis"
WORKSPACE=$ROOT_DIR/$REPO
LUSTRE_DATASET="${SCRATCH}/imagenet_processed/200g"
LOCAL_DATASET="/tmp/100g"
echo "Loading gcc and python modules"
echo "module load gcc/8.3.0"
export CC="/opt/apps/gcc/8.3.0/bin/gcc"
echo "module load cuda/10.1/10.1.243 cudnn/7.6/7.6.5 nccl/2.4/2.4.8-1 openmpi/2.1.6"
module load cuda/10.1
module load cudnn/7.6.5
module load nccl/2.5.6
module load remora
echo "cd ${WORKSPACE}/pytorch/scripts"
cd "${WORKSPACE}/pytorch/scripts"
echo "cp ${SCRATCH}/objects/44g.zip /dev/shm"
cp "${SCRATCH}/objects/44g.zip" /dev/shm
echo "cp ${SCRATCH}/objects/7g.zip /dev/shm"
cp "${SCRATCH}/objects/7g.zip" /dev/shm
echo "cp ${SCRATCH}/objects/6g.zip /dev/shm"
cp "${SCRATCH}/objects/6g.zip" /dev/shm
echo "cp ${SCRATCH}/objects/3g /dev/shm"
cp "${SCRATCH}/objects/3g" /dev/shm
for i in {1..1}
do
remora ./train.sh -m lenet -b 256 -e 3 -w 1 -i -f 100 -d $LUSTRE_DATASET
remora ./train.sh -m alexnet -b 256 -e 3 -w 1 -i -f 100 -d $LUSTRE_DATASET
remora ./train.sh -m resnet50 -b 256 -e 3 -w 1 -i -f 100 -d $LUSTRE_DATASET
done
