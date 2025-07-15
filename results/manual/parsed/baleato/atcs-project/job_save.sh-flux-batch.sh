#!/bin/bash
#FLUX: --job-name=Emo_classf
#FLUX: -c=3
#FLUX: --queue=gpu_shared_course
#FLUX: -t=57600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/hpc/eb/Debian9/cuDNN/7.1-CUDA-8.0.44-GCCcore-5.4.0/lib64:$LD_LIBRARY_PATH'

module purge
module load pre2019
module load Python/3.6.3-foss-2017b
module load cuDNN/7.0.5-CUDA-9.0.176
module load NCCL/2.0.5-CUDA-9.0.176
export LD_LIBRARY_PATH=/hpc/eb/Debian9/cuDNN/7.1-CUDA-8.0.44-GCCcore-5.4.0/lib64:$LD_LIBRARY_PATH
SAVE_NAME=0_Example/
LISA_HOME=$(pwd)
mkdir -p ${LISA_HOME}/${SAVE_NAME}
USER=`whoami`
WORKING_DIR=${TMPDIR}/${USER}
mkdir -p ${WORKING_DIR}
cp -r ~/atcs-project ${WORKING_DIR}/
cd ${WORKING_DIR}/atcs-project
pip install --user -r requirements.txt
srun python train.py --save_path ~/results/${SAVE_NAME}
cp ~/results/${SAVE_NAME}snap* ${LISA_HOME}/${SAVE_NAME}
cp ~/results/${SAVE_NAME}best* ${LISA_HOME}/${SAVE_NAME}
cp -r ~/results/runs/* ${LISA_HOME}/results/runs/
