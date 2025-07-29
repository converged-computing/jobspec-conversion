#!/bin/bash
#SBATCH --job-name=M4
#SBATCH --output=%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu
#SBATCH --mem=64GB
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
singularity exec --nv \
            --overlay /scratch/vg2097/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
            /bin/bash -c "source /ext3/env.sh; python main.py -en 17 -o sgd -dp ./data -b 2 2 2 2 -c 72 110 196 308"
singularity exec --nv \
            --overlay /scratch/vg2097/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
            /bin/bash -c "source /ext3/env.sh; python main2.py -en 18 -o sgd -dp ./data -b 2 2 2 2 -c 42 84 168 336"
singularity exec --nv \
            --overlay /scratch/vg2097/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
            /bin/bash -c "source /ext3/env.sh; python main3.py -en 19 -o sgd -dp ./data -b 2 2 2 2 -c 42 84 168 336"
