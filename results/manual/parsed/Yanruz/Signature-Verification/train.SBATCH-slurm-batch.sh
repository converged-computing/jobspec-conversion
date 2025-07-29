#!/bin/bash
#SBATCH --job-name=cv
#SBATCH --mail-user=ds5749@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=48GB
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
singularity exec --nv \
    --overlay /scratch/ds5749/NLQ/overlay-15GB-500K.ext3:ro /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif /bin/bash -c \
    "source /ext3/miniconda3/etc/profile.d/conda.sh; conda activate vslnet; 
    python siamese_train.py --model_name TransformerNet --epochs 10 --batch_size 32 --loss BCE"
    # SiameseConvNet, TransformerNet, vit_base, resnet, resnet_pretrained
