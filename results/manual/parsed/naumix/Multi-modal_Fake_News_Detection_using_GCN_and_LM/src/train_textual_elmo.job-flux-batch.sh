#!/bin/bash
#FLUX: --job-name=PROJECTAI_ELMo
#FLUX: -c=2
#FLUX: --queue=gpu_shared_course
#FLUX: -t=36000
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/hpc/eb/Debian9/cuDNN/7.1-CUDA-8.0.44-GCCcore-5.4.0/lib64:$LD_LIBRARY_PATH'

module purge
module load eb
module load Python/3.6.3-foss-2017b
module load cuDNN/7.0.5-CUDA-9.0.176
module load NCCL/2.0.5-CUDA-9.0.176
export LD_LIBRARY_PATH=/hpc/eb/Debian9/cuDNN/7.1-CUDA-8.0.44-GCCcore-5.4.0/lib64:$LD_LIBRARY_PATH
source ../venv/bin/activate
pip3 install torch torchtext numpy matplotlib pandas allennlp
srun python train.py --model_type=elmo --run_desc=only_elmo
