#!/bin/bash
#SBATCH --job-name=fn
#SBATCH --output=./fn.out
#SBATCH --error=./fn.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=320GB
#SBATCH --time=2-00:00:00
#SBATCH --qos=high
#SBATCH --nodelist=gpu16

python ForgeryNet.py -path '/share/home/zhangchao/datasets_io03_ssd/ForgeryNet' -save_path '/share/home/zhangchao/datasets_io03_ssd/ForgeryNet' -scale 1.3 -detector dlib -workers 32
