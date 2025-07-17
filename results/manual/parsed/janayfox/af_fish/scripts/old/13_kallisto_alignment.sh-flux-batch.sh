#!/bin/bash
#FLUX: --job-name=scruptious-animal-0095
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --urgency=16

module load singularity/3.8
module load nixpkgs/16.09
module load gcc/9.3.0
module load intel/2020.1.217
module load kallisto/0.46.1
singularity exec -e -B /home/janayfox/scratch/afFishRNA/readsBeforeRmoverrep/BA:/data \
trinityrnaseq.v2.15.0.simg /usr/local/bin/util/align_and_estimate_abundance.pl \
--transcripts /data/BA_bf.Trinity.fasta --est_method kallisto \
--trinity_mode --prep_reference
singularity exec -e -B /home/janayfox/scratch/afFishRNA/:/data \
trinityrnaseq.v2.15.0.simg /usr/local/bin/util/align_and_estimate_abundance.pl \
--transcripts /data/readsBeforeRmoverrep/BA/BA_bf.Trinity.fasta --seqType fq --SS_lib_type RF \
--samples_file /data/readsBeforeRmoverrep/BN/samples_BA_kal_bf.txt \
--est_method kallisto --trinity_mode --output_dir kallisto_output
