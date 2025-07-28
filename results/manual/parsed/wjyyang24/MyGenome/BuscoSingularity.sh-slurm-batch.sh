#!/bin/bash
#FLUX: --job-name=busco
#FLUX: -c=16
#FLUX: --queue=normal
#FLUX: -t=28800
#FLUX: --urgency=16

echo "SLURM_NODELIST: "$SLURM_NODELIST
echo "PWD :" $PWD
in=$1
out=${in/\.fasta/}_busco
module load ccs/singularity
singularity run --app busco570 /share/singularity/images/ccs/conda/amd-conda14-rocky8.sinf busco \
 --in $in --out $out --mode genome --lineage_dataset ascomycota_odb10 -f
