#!/bin/bash
#SBATCH --job-name=synth_gen_pan_TCGA
#SBATCH --output=./output_reports/slurm.%N.%j.out
#SBATCH --error=./error_reports/slurm.%N.%j.err
#SBATCH --mail-user=<user>@<org>.edu
#SBATCH --mail-type=END,FAIL,START
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=02:00:00

source project_root/bin/activate
python HLVS.py 'output_dir_name/' '/train_file_path/*.tsv' $1 40 10 150
