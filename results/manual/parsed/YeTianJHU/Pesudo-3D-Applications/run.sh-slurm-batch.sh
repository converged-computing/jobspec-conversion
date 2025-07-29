#!/bin/bash
#SBATCH --job-name=9
#SBATCH --mail-user=ytian27@jhu.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

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
