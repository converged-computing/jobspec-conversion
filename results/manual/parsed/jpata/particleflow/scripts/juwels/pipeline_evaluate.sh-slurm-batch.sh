#!/bin/bash
#FLUX: --job-name=pipeeval
#FLUX: --queue=booster
#FLUX: -t=7199
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module purge
module load GCC/10.3.0 CUDA/11.0 cuDNN/8.0.2.39-CUDA-11.0
export CUDA_VISIBLE_DEVICES=0
jutil env activate -p prcoe12
nvidia-smi
source /p/project/prcoe12/wulff1/miniconda3/bin/activate tf2
echo "Python used:"
which python3
python3 --version
echo 'Starting evaluation.'
CUDA_VISIBLE_DEVICES=0 python3 mlpf/pipeline.py evaluate -c $1 -t $2
echo 'Evaluation done.'
rsync -a experiments/ $SLURM_SUBMIT_DIR/experiments/
