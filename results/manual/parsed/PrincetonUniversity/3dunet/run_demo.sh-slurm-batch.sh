#!/bin/bash
#SBATCH --output=demo_%j.out
#SBATCH --error=demo_%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=5000
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=2,ntasks-per-socket=1

module load cudatoolkit/10.0 cudnn/cuda-10.0/7.3.1 anaconda3/5.3.1
. activate 3dunet
echo 'Folder to save: '
demo_folder=$(pwd)$'/demo'
echo $demo_folder
python setup_demo_script.py $demo_folder
cd pytorchutils
echo $(pwd)
python demo.py demo models/RSUNet.py samplers/demo_sampler.py augmentors/flip_rotate.py 10 --batch_sz 1 --nobn --noeval --tag demo
