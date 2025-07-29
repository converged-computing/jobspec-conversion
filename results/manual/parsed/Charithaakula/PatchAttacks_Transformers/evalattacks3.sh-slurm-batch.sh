#!/bin/bash
#SBATCH --job-name=jobName
#SBATCH --output=allattacks/slurm_%j.out
#SBATCH --error=allattacks/slurm_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=24G
#SBATCH --time=07:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=/scratch/sca321/robustness/attacks/ameya/Transformer-attacks-master/PatchAttacks2

module purge
singularity exec --nv \
        --overlay /vast/work/public/ml-datasets/imagenet/imagenet-val.sqf:ro \
        --overlay /vast/work/public/ml-datasets/imagenet/imagenet-train.sqf:ro \
	    --overlay /scratch/sca321/conda/simple2/overlay-50G-10M.ext3:ro \
	    /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
	    /bin/bash -c "source /ext3/env.sh; python patchattackgrad_multi.py -o alloutputs/$1 -mt $1 --gpu 0 -dpath $2  -it $3 -mp $4 -ni $5 -clip -lr $6 -ps $7 -si $8;"
