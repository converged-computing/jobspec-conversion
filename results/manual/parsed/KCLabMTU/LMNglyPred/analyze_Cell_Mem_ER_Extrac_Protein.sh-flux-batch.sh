#!/bin/bash
#FLUX: --job-name=stanky-general-0045
#FLUX: -c=18
#FLUX: --urgency=16

export FILENAME='$(ls ${BASEDIR}/*.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p)'

module load TensorFlow/2.6.2-foss-2021a
source ~/virtualenvs/Dashain/bin/activate
BASEDIR=/home/t326h379/Cell_Mem_ER_Extrac_Protein
export FILENAME=$(ls ${BASEDIR}/*.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p)
python ~/analyze_Cell_Mem_ER_Extrac_Protein.py
