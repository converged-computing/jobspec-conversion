#!/bin/bash
#FLUX: --job-name=sasrec
#FLUX: --queue=gpu_shared_course
#FLUX: -t=43200
#FLUX: --priority=16

export LD_LIBRARY_PATH='/hpc/eb/Debian9/cuDNN/7.1-CUDA-8.0.44-GCCcore-5.4.0/lib64:$LD_LIBRARY_PATH'

module purge
module load eb
module load python/2.7.9
module load cuDNN/7.0.5-CUDA-9.0.176
module load NCCL/2.0.5-CUDA-9.0.176
export LD_LIBRARY_PATH=/hpc/eb/Debian9/cuDNN/7.1-CUDA-8.0.44-GCCcore-5.4.0/lib64:$LD_LIBRARY_PATH
echo "[SASRec] Job $SLURM_JOBID started at `date`" | mail $USER -s "Job $SLURM_JOBID"
pip2 install virtualenv 
python2 -m virtualenv sasrec
. sasrec/bin/activate
pip2 install -r requirements.txt
python2 main.py --dataset=ml-1m --train_dir=default --maxlen=200 --dropout_rate=0.2 
echo "[SASRec] Job $SLURM_JOBID finished at `date`" | mail $USER -s "Job $SLURM_JOBID"
