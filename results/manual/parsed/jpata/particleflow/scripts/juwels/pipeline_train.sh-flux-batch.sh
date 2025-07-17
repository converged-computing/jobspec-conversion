#!/bin/bash
#FLUX: --job-name=pipetrain
#FLUX: --queue=booster
#FLUX: -t=86399
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1,2,3'

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module purge
module load GCC/10.3.0 CUDA/11.0 cuDNN/8.0.2.39-CUDA-11.0
export CUDA_VISIBLE_DEVICES=0,1,2,3
jutil env activate -p prcoe12
nvidia-smi
source /p/project/prcoe12/wulff1/miniconda3/bin/activate tf2
echo "Python used:"
which python3
python3 --version
mkdir $SCRATCH/particleflow
rsync -ar --exclude={".git","experiments"} . $SCRATCH/particleflow/
cd $SCRATCH/particleflow
if [ $? -eq 0 ]
then
  echo "Successfully changed directory"
else
  echo "Could not change directory" >&2
  exit 1
fi
echo 'Starting training.'
CUDA_VISIBLE_DEVICES=0,1,2,3 python3 mlpf/pipeline.py train -c $1 -p $2
echo 'Training done.'
rsync -a experiments/ $SLURM_SUBMIT_DIR/experiments/
