#!/bin/bash
#SBATCH --job-name=eval_kp_one2one_duc
#SBATCH --output=slurm_output/eval_kp_one2one_duc.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64GB
#SBATCH --time=6-00:00:00
#SBATCH --partition=smp
#SBATCH --qos=long
#SBATCH --constraint=ntasks-per-node=1

python kp_gen_eval.py -config config/test/config-test-keyphrase.yml -data_dir data/keyphrase/meng17/ -ckpt_dir models/keyphrase/meng17/ -output_dir output/keyphrase/meng17/ -testsets duc -gpu -1
