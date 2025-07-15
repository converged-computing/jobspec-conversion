#!/bin/bash
#FLUX: --job-name="Emo_classf"
#FLUX: -c=3
#FLUX: --queue=gpu_shared_course
#FLUX: -t=36000
#FLUX: --priority=16

export LD_LIBRARY_PATH='/hpc/eb/Debian9/cuDNN/7.1-CUDA-8.0.44-GCCcore-5.4.0/lib64:$LD_LIBRARY_PATH'

module purge
module load pre2019
module load Python/3.6.3-foss-2017b
module load cuDNN/7.0.5-CUDA-9.0.176
module load NCCL/2.0.5-CUDA-9.0.176
export LD_LIBRARY_PATH=/hpc/eb/Debian9/cuDNN/7.1-CUDA-8.0.44-GCCcore-5.4.0/lib64:$LD_LIBRARY_PATH
USER=`whoami`
WORKING_DIR=${TMPDIR}/${USER}
mkdir -p ${WORKING_DIR}
cp -r ~/atcs-project ${WORKING_DIR}/
LISA_HOME=$(pwd)
cd ${WORKING_DIR}/atcs-project
pip install --user -r requirements.txt
srun python train_prototype.py --save_path ~/results/
cp ~/results/snap* ${LISA_HOME}
cp ~/results/best* ${LISA_HOME}
cp ~/results/runs/* ${LISA_HOME}
