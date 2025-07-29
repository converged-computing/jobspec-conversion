#!/bin/bash
#SBATCH --account=def-panos
#SBATCH --mail-user=$USER@ece.ubc.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=00:50:00

export LD_LIBRARY_PATH='{$LD_LIBRARY_PATH}:$CUDA_HOME/lib64:/cvmfs/soft.computecanada.ca/easybuild/software/2017/CUDA/cuda10.1/cudnn/7.6.5/lib64/'

module load python/3.6
module load nixpkgs/16.09  intel/2018.3  cuda/10.1 cudnn/7.6.5
source /home/$USER/env_fastsrgan/bin/activate
export LD_LIBRARY_PATH={$LD_LIBRARY_PATH}:$CUDA_HOME/lib64:/cvmfs/soft.computecanada.ca/easybuild/software/2017/CUDA/cuda10.1/cudnn/7.6.5/lib64/
cd /home/$USER/scratch/Fast-SRGAN-ITMO
echo $PWD
echo "Inference..."
python infer.py --image_dir images --output_dir output \
--gen "models/20200616091300_28500_generator.h5"
