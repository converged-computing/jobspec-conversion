#!/bin/bash
#SBATCH --job-name=horovod_1GPU
#SBATCH --output=jobs/hvd_1_%j.output
#SBATCH --error=jobs/hvd_1_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:1
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=.

module purge; module load gcc/8.3.0 cuda/10.2 cudnn/7.6.4 nccl/2.4.8 tensorrt/6.0.1 openmpi/4.0.1 atlas/3.10.3 scalapack/2.0.2 fftw/3.3.8 szip/2.1.1 ffmpeg/4.2.1 opencv/4.1.1 python/3.7.4_ML
horovodrun -np $SLURM_NTASKS -H localhost:$SLURM_NTASKS --gloo \
python3.7 tf2_keras_cifar_hvd.py --epochs 10  --batch_size 512 --model_name='resnet'
