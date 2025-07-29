#!/bin/bash
#SBATCH --job-name=dp_llama_cs798Research_job
#SBATCH --output=/scratch/dmeher/slurm_outputs/dp_llama_cs798Research.%j.out
#SBATCH --error=/scratch/dmeher/slurm_outputs/dp_llama_cs798Research.%j.err
#SBATCH --mail-user=dmeher@gmu.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100.40gb:1
#SBATCH --mem=80GB
#SBATCH --time=5-00:00:00
#SBATCH --qos=gpu
#SBATCH --constraint=ntasks-per-node=1

set echo
umask 0027
nvidia-smi
module load gnu10
module load python
source /scratch/dmeher/custom_env/llama_env/bin/activate
python overlapping.py \
  --amazon_dataset_dir /scratch/dmeher/datasets_recguru/ \
  --dataset1 reviews_Movies_and_TV_5.csv \
  --dataset2 reviews_Books_5.csv \
  --overlapping_output_dir /scratch/dmeher/booktgt_PTUPCDR_CS798/data/mid \
  --output_file1 movie_moviebook_overlapping.csv \
  --output_file2 book_moviebook_overlapping.csv
