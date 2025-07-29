#!/bin/bash
#SBATCH --job-name=eval_kp_one2many_nus
#SBATCH --output=slurm_output/eval_kp_one2many_nus.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64GB
#SBATCH --time=6-00:00:00
#SBATCH --partition=smp
#SBATCH --qos=long
#SBATCH --constraint=ntasks-per-node=1

python kp_run_eval.py -config script/srun_one2many/kpeval-beam10-maxlen40/config-test-keyphrase-one2many.yml -data_dir data/keyphrase/meng17/ -ckpt_dir models/keyphrase/meng17/ -output_dir output/keyphrase/meng17-one2many-beam10-maxlen40/ -gpu -1 -testsets nus
