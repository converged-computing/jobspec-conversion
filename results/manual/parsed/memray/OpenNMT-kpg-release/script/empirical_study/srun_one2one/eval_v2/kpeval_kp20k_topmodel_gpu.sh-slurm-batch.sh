#!/bin/bash
#SBATCH --job-name=eval_one2one_kp20k-top-gpu
#SBATCH --output=slurm_output/eval_one2one_kp20k-top-gpu.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64GB
#SBATCH --time=3-00:00:00
#SBATCH --qos=long
#SBATCH --constraint=ntasks-per-node=1

python kp_gen_eval.py -config config/test/config-test-keyphrase-one2one.yml -data_dir data/keyphrase/meng17/ -ckpt_dir models/keyphrase/meng17-one2one/meng17-one2one-kp20k-topmodels/ -output_dir output/keyphrase/meng17-one2one/meng17-one2one-kp20k-topmodels/ -testsets kp20k -gpu 0 -batch_size 4 -tasks pred
