#!/bin/bash
#SBATCH --account=topo
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=3-00:00:00
#SBATCH --qos=gpu
#SBATCH --exclusive
#SBATCH --chdir=/home/qyan/TransPose

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$(pwd)/install/lib:$(pwd)/install/lib64'

module load gcc cmake
source /home/qyan/venvtranspose/bin/activate
cd opencv-build
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)/install/lib:$(pwd)/install/lib64
python3 -c "import torch; import dsacstar"
echo start at `date`
python3 /home/qyan/TransPose/script/foo.py
echo finished at `date`
