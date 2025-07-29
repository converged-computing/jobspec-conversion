#!/bin/bash
#FLUX: --job-name=picrust2
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --urgency=16

export PATH='$PATH:$HOME/anaconda3/bin'

echo Job: $SLUM_JOB_NAME with ID $SLURM_JOB_ID
echo Running on host `hostname`
echo Job started at `date '+%T %a %d %b %Y'`
echo Directory is `pwd`
echo Using $SLURM_NTASKS processors across $SLURM_NNODES nodes
WORK_DIRECTORY=/mnt/home/vascokar/marine_iguana/results/qiime2
module purge
module load Conda/3
export PATH=$PATH:$HOME/anaconda3/bin
conda init bash
conda activate qiime2-2021.2
cd $WORK_DIRECTORY
qiime picrust2 full-pipeline \
   --i-table table-dn-97.qza \
   --i-seq rep-seqs-dn-97.qza \
   --output-dir q2-picrust2_output \
   --p-threads 4 \
   --p-hsp-method mp \
   --p-max-nsti 2 \
   --verbose
conda deactivate
echo Job finished at `date '+%T %a %d %b %Y'`
