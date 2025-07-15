#!/bin/bash
#FLUX: --job-name=ecco_mmap
#FLUX: -c=4
#FLUX: --queue=small
#FLUX: -t=36000
#FLUX: --priority=16

module load pytorch/1.11
pip3 install -r requirements.txt
zcat /scratch/project_2002820/emil/ecco_faiss/ecco.jsonl.gz | python3  mmap_index.py --index-lines-to all_data_pos_uniq
