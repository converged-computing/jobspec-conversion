#!/bin/bash
#FLUX: --job-name=dp_llama_cs798Research_job
#FLUX: --queue=gpuq
#FLUX: -t=432000
#FLUX: --urgency=16

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
