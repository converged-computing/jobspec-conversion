#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --mem=15GB
#SBATCH --time=7-00:00:00
#SBATCH --constraint=ntasks-per-node=1

singularity exec --overlay /scratch/zp2137/text-mining/overlay-25GB-500K.ext3:ro \
        /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
        /bin/bash -c "source /ext3/env.sh; conda activate py36; time python alloyDesign-para.py"
