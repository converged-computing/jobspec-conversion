#!/bin/bash
#FLUX: --job-name=9
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

export SINGULARITY_HOME='$PWD:/home/$USER '

module load cuda/9.0
module load singularity/2.4
module load git
echo "Using GPU Device:"
echo $CUDA_VISIBLE_DEVICES
export SINGULARITY_HOME=$PWD:/home/$USER 
singularity pull --name pytorch.simg shub://marcc-hpc/pytorch
singularity exec --nv ./pytorch.simg python train.py --machine=marcc --gpuid=$CUDA_VISIBLE_DEVICES  --model=C3D --use_trained_model=1
echo "Finished with job $SLURM_JOBID"
