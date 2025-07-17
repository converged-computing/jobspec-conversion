#!/bin/bash
#FLUX: --job-name=pQuant_enc
#FLUX: --queue=pe2
#FLUX: --urgency=16

module add gcc/9.2.0
module add clang
module add cmake
cd /gpfs/commons/groups/gursoy_lab/shong/Github/pQuant_enc/build
kmer_matrix_loc="../../pQuant_rust/kmer_matrix/kmer_$1_$2_$3.json"
echo "Slum job number = $SLURM_JOB_ID"
if [ "$4" = true ]; then
    ./pquant -t all -d $2 -k $1 -b -m $kmer_matrix_loc --debug_n_gene 5 --memory -e $3 
else
    ./pquant -t all -d $2 -k $1 -b --debug_n_gene 5 -e $3
fi
 # don't use kmer matrix
