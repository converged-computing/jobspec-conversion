#!/bin/bash
#FLUX: --job-name=butterscotch-spoon-5034
#FLUX: --priority=16

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module purge
module load slurm gcc cuda/11.1.0_455.23.05 cudnn/v8.0.4-cuda-11.1
nvidia-smi
source ~/miniconda3/bin/activate tf2
which python3
python3 --version
mkdir $TMPDIR/particleflow
rsync -ar --exclude=".git" . $TMPDIR/particleflow
cd $TMPDIR/particleflow
if [ $? -eq 0 ]
then
  echo "Successfully changed directory"
else
  echo "Could not change directory" >&2
  exit 1
fi
python3 tf_list_gpus.py
echo 'Starting validation.'
CUDA_VISIBLE_DEVICES=0,1,2,3 python3 mlpf/launcher.py --action eval --model-spec parameters/delphes-gnn-skipconn.yaml --weights $1
echo 'Valdiation done.'
rsync -a experiments/ /mnt/ceph/users/ewulff/experiments/
