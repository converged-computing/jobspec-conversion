#!/bin/bash
#SBATCH --job-name=SU_LOUO8
#SBATCH --mail-user=tkim60@jhu.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1

module restore mymodules
module load tensorflow/cuda-8.0/r1.0
echo "Using GPU Device:"
echo $CUDA_VISIBLE_DEVICES
python /home-4/tkim60@jhu.edu/scratch/dev/jigsaws/train_jigsaws.py --gpu=$CUDA_VISIBLE_DEVICES > /home-4/tkim60@jhu.edu/scratch/dev/jigsaws/LOUO8_SU_$SLURM_JOBID.log
echo "Finished with job $SLURM_JOBID"
