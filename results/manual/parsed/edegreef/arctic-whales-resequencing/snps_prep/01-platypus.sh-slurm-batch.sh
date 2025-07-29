#!/bin/bash
#FLUX: --job-name=platypus
#FLUX: -c=32
#FLUX: -t=43200
#FLUX: --urgency=16

module load nixpkgs/16.09 gcc/7.3.0 platypus/0.8.1
cd /scratch/edegreef/whales/dedupRG_bam/samtools_filter/downsampled
python /cvmfs/soft.computecanada.ca/easybuild/software/2017/avx2/Compiler/gcc7.3/platypus/0.8.1/bin/Platypus.py callVariants \
--bamFiles=bowhead_whale_bams.txt \
--refFile=/scratch/edegreef/whales/ref_genomes/rclone/BOW_reference.fasta \
--output=/scratch/edegreef/whales/bowhead_allvariantcalls_pp.vcf \
--nCPU=32 --minReads=4
