#!/bin/bash
#FLUX: --job-name=blastn
#FLUX: --queue=defq,short
#FLUX: -t=86400
#FLUX: --urgency=16

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p seq_list.txt)
cd ../data/seq
module load python/2.7.6
module load clustalw2
module load blast+
blastn -query macse.precluster.pick.pick.redundant_CROP.cluster.fasta -db /groups/cbi/bryan/COI_all.fasta -perc_identity 97 -outfmt 6 -out blast_all_real2 -qcov_hsp_perc 50
