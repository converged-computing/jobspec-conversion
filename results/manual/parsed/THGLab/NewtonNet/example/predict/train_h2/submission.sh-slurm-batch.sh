#!/bin/bash
#SBATCH --job-name=morse
#SBATCH --account=lr_ninjaone
#SBATCH --output=out.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:4
#SBATCH --mem=16G
#SBATCH --time=4-00:00:00
#SBATCH --qos=condo_ninjaone_es1
#SBATCH --constraint=es1_2080ti

source activate newtonnet
python ~/NewtonNet/cli/newtonnet_train -c ~/20230120_AnalPES/config.yml
