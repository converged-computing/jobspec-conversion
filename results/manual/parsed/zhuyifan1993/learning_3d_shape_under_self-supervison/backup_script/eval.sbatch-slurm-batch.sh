#!/bin/bash
#SBATCH --job-name=zyf_thesis
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --mail-user=yifan.zhu@student.uni-tuebingen.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=3G
#SBATCH --time=1-00:00:00
#SBATCH --partition=day

cp -R /common/datasets/MNIST/ /scratch/$SLURM_JOB_ID/
singularity exec /common/singularityImages/TCML-Cuda10_0_TF1_15_2_PT1_4.simg python3 ~/evaluation.py ~/model/ /scratch/$SLURM_JOB_ID/MNIST/
echo DONE!
