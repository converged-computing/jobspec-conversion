#!/bin/bash
#SBATCH --job-name=nc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu
#SBATCH --mem=80GB
#SBATCH --time=2-00:00:00

ext3_path=/scratch/$USER/python36/python36.ext3
sif_path=/scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif
singularity exec --nv \
--overlay ${ext3_path}:ro \
${sif_path} /bin/bash -c "
source /ext3/env.sh
python main.py --dset fmnist --model resnet18 --koleo_wt 0.01 --loss ce --koleo_type c --exp_name wd54_klc01
"
