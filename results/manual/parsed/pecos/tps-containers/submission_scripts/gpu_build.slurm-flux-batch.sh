#!/bin/bash
#FLUX: --job-name=build-tps
#FLUX: --queue=gpu-a100-small
#FLUX: -t=3600
#FLUX: --urgency=16

export ORG='uvilla'
export IMAGE_NAME='tps_env_parla'
export TAG='gnu9-mvapich2-sm_80'
export IMAGE='$(pwd)/${IMAGE_NAME}_$TAG.sif'

module purge
module load gcc/11.2.0 mvapich2/2.3.7 tacc-apptainer/1.1.8 cuda/11.4
ml list
export ORG=uvilla
export IMAGE_NAME=tps_env_parla
export TAG=gnu9-mvapich2-sm_80
export IMAGE=$(pwd)/${IMAGE_NAME}_$TAG.sif
rm -f $IMAGE
apptainer pull docker://$ORG/$IMAGE_NAME:$TAG
cd tps
apptainer exec --nv --cleanenv $IMAGE /bin/bash --login -c "./bootstrap"
rm -rf build-gpu
mkdir build-gpu && cd build-gpu
echo ---CONFIGURE---
MV2_SMP_USE_CMA=0 apptainer exec --nv  --cleanenv $IMAGE /bin/bash --login -c "../configure --enable-pybind11 --enable-gpu-cuda"
echo ---MAKE -J---
apptainer exec --nv --cleanenv $IMAGE /bin/bash --login -c "make -j 6"
echo ---CREATE VPATH---
apptainer exec --nv --cleanenv $IMAGE /bin/bash --login -c "make -j 6 check TESTS=vpath.sh"
echo ---CAT tps.conf---
apptainer exec --nv $IMAGE cat /etc/ld.so.conf.d/tps.conf
apptainer exec --nv $IMAGE ldd ./src/.libs/tps | grep not
apptainer exec --nv $IMAGE ldd ./src/.libs/libtps.so
apptainer exec --nv $IMAGE ldd ./src/.libs/libtps.so | grep not
