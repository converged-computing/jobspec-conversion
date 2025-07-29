#!/bin/bash
#SBATCH --job-name=M1
#SBATCH --output=%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu
#SBATCH --mem=32GB
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
singularity exec --nv \
            --overlay /scratch/vg2097/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
            /bin/bash -c "source /ext3/env.sh; python main.py -en 1 -o sgd -dp ./data -b 2 2 2 2 -c 54 96 188 324"
singularity exec --nv \
            --overlay /scratch/vg2097/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
            /bin/bash -c "source /ext3/env.sh; python main.py -en 2 -o adagrad -dp ./data -b 2 2 2 2 -c 54 96 188 324"
singularity exec --nv \
            --overlay /scratch/vg2097/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
            /bin/bash -c "source /ext3/env.sh; python main.py -en 3 -o adadelta -dp ./data -b 2 2 2 2 -c 54 96 188 324"
singularity exec --nv \
            --overlay /scratch/vg2097/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
            /bin/bash -c "source /ext3/env.sh; python main.py -en 4 -o adam -dp ./data -b 2 2 2 2 -c 54 96 188 324"
