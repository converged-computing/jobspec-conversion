#!/bin/bash
#SBATCH --job-name=D-DETR_test
#SBATCH --output=myjobresults-%J.out
#SBATCH --error=myjobresults-%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=1

conda create -n deformable_detr python=3.7 pip
conda activate deformable_detr
conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch
pip install -r requirements.txt
cd Deformable-DETR
cd ./models/ops
sh ./make.sh
python test.py
