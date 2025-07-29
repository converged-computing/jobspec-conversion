#!/bin/bash
#SBATCH --job-name=preprocess_kp20k
#SBATCH --output=slurm_output/preprocess_kp20k.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32GB
#SBATCH --time=6-00:00:00
#SBATCH --qos=long
#SBATCH --constraint=ntasks-per-node=1

cmd="srun python -m preprocess -config config/preprocess/config-preprocess-keyphrase-kp20k.yml"
echo $cmd
$cmd
