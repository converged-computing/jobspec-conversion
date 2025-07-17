#!/bin/bash
#FLUX: --job-name=51
#FLUX: -c=12
#FLUX: --queue=gpgpu
#FLUX: -t=172740
#FLUX: --urgency=16

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
cd /data/cephfs/punim0784/nas_research//COMP90051-Project1/
module load Python/3.5.2-intel-2017.u2-GCC-5.4.0-CUDA9
nvidia-smi
python3 -u train_sentence_transformers.py
