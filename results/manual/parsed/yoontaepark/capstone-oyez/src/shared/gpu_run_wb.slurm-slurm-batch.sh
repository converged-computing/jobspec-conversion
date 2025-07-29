#!/bin/bash
#SBATCH --job-name=myTest
#SBATCH --output=slurm_%j.out
#SBATCH --mail-user=yp2201@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=128GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge    
singularity exec --nv --bind $SCRATCH/comp_gen --overlay $SCRATCH/overlay-25GB-500K.ext3:ro \
            /scratch/work/public/singularity/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif /bin/bash -c "
source /ext3/env.sh
conda activate
pip install rouge
CUDA_LAUNCH_BLOCKING=1 python $SCRATCH/capstone_wb/wb_code_v2.py conclusion --finetune
"
