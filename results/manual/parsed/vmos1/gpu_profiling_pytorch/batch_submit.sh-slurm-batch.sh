#!/bin/bash
#SBATCH --job-name=cnn_pytorch
#SBATCH --account=m3363
#SBATCH --output=slurm-%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --qos=regular
#SBATCH --constraint=gpu,ntasks-per-node=8

echo "--start date" `date` `date +%s`
echo '--hostname ' $HOSTNAME
conda activate v3
module load nsight-systems
srun nsys profile --stats=true -t nvtx,cuda python pytorch_cnn.py -b 256 -e 10
echo "--end date" `date` `date +%s`
