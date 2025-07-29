#!/bin/bash
#SBATCH --job-name=DOT_job
#SBATCH --output=Dot_nr0.4_cifar10.out
#SBATCH --error=Dot_nr0.4_cifar10.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu
#SBATCH --mem=80GB
#SBATCH --time=2-00:00:00

ext3_path=/scratch/$USER/overlay-25GB-500K.ext3
sif_path=/scratch/$USER/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif
train_file=train
noise_rate=0.4
batch_size=128
dataset_type='cifar10'
epoch=120
version=Dot_nr04_cifar10
singularity exec --nv \
--overlay ${ext3_path}:ro \
${sif_path} /bin/bash -c "
source /ext3/env.sh
cd /scratch/qz2208/SCELoss-Reproduce
python -m ${train_file} --nr ${noise_rate} \
--batch_size ${batch_size} --dataset_type ${dataset_type} \
--epoch ${epoch} --version ${version}
"
