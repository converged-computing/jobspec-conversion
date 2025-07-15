#!/bin/bash
#FLUX: --job-name=cowy-poo-5655
#FLUX: --exclusive
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0,1,2,3'

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module --force purge; module load modules/2.0
module load slurm gcc cmake cudnn cuda openmpi/cuda
nvidia-smi
export CUDA_VISIBLE_DEVICES=0,1,2,3
source ~/miniconda/bin/activate tf
which python3
python3 --version
mkdir $TMPDIR/particleflow
rsync -ar --exclude={".git","experiments"} . $TMPDIR/particleflow
cd $TMPDIR/particleflow
if [ $? -eq 0 ]
then
  echo "Successfully changed directory"
else
  echo "Could not change directory" >&2
  exit 1
fi
mkdir experiments
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
nodes_array=( $nodes )
node_server=""
for str in ${nodes_array[@]}; do
  node_server=$node_server$str:4,
done
nod=${node_server: : -1}
echo 'Starting training.'
python3 mlpf/pipeline.py train -c $1 -p $2
echo 'Training done.'
rsync -a experiments/ /mnt/ceph/users/larssorl/experiments/
