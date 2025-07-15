#!/bin/bash
#FLUX: --job-name=prokka_EC
#FLUX: --queue=bio-compute,lowpri
#FLUX: -t=691199
#FLUX: --priority=16

cd /mnt/scratch2/users/40309916/E_coli_genomes/genomes/prokka_analysis
module load apps/anaconda3
source activate /mnt/scratch2/igfs-anaconda/conda-envs/prokka
file_list=$(ls *.fna | sed -n ${SLURM_ARRAY_TASK_ID}p)
for file_list in `ls *.fna | sed -n $(expr $(expr ${SLURM_ARRAY_TASK_ID} \* 100) - 99),$(expr ${SLURM_ARRAY_TASK_ID} \* 100)p`; do
  prokka --outdir prokka_output/${file_list%.*} --prefix ${file_list%.*} $file_list;
done
