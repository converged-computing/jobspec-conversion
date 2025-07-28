#!/bin/bash
#FLUX: --job-name=staridx
#FLUX: -n=12
#FLUX: -t=36000
#FLUX: --urgency=16

module purge
module load star/intel
RUNDIR=/scratch/cr1636/ATAC_Ciona_sana_claudia/RNAseq_foxf_ngn_lacz_june2017/2017-06-28_HKHMWAFXX/merged/
cd $RUNDIR
STAR --runThreadN 12 --runMode genomeGenerate --genomeDir star --genomeFastaFiles /scratch/cr1636/august/JoinedScaffold --sjdbGTFfile /scratch/cr1636/august/KH.KHGene.2013.gtf
exit 0;
