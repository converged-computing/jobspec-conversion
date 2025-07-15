#!/bin/bash
#FLUX: --job-name=merqury
#FLUX: -c=10
#FLUX: -t=1800
#FLUX: --priority=16

export PATH='$PATH:/cluster/projects/nn9525k/Programs/meryl-1.0/Linux-amd64/bin'
export MERQURY='/cluster/projects/nn9525k/Programs/merqury'

module purge
module load Java/11.0.2
module load BEDTools/2.28.0-GCC-8.2.0-2.31.1
module swap GCCcore/8.2.0 GCCcore/8.3.0
module swap zlib/1.2.11-GCCcore-8.2.0 zlib/1.2.11-GCCcore-8.3.0
module swap binutils/2.31.1-GCCcore-8.2.0 binutils/2.32-GCCcore-8.3.0
module swap GCC/8.2.0-2.31.1 GCC/8.3.0
module swap bzip2/1.0.6-GCCcore-8.2.0 bzip2/1.0.8-GCCcore-8.3.0
module swap XZ/5.2.4-GCCcore-8.2.0 XZ/5.2.4-GCCcore-8.3.0
module load SAMtools/1.10-GCC-8.3.0
module load R/3.6.2-fosscuda-2019b
export PATH=$PATH:/cluster/projects/nn9525k/Programs/IGV_2.8.2
export PATH=$PATH:/cluster/projects/nn9525k/Programs/meryl-1.0/Linux-amd64/bin
export MERQURY=/cluster/projects/nn9525k/Programs/merqury
module list
$MERQURY/merqury.sh petraea_illumina.k19.meryl petraea_canu_purged_ragoo.fasta petraea_canu_purged_ragoo
