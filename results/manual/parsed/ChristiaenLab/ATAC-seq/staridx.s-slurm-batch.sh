#!/bin/bash
#SBATCH --job-name=staridx
#SBATCH --output=staridx.out
#SBATCH --error=staridx.err
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8GB
#SBATCH --time=10:00:00

module purge
module load star/intel
RUNDIR=/scratch/cr1636/ATAC_Ciona_sana_claudia/RNAseq_foxf_ngn_lacz_june2017/2017-06-28_HKHMWAFXX/merged/
cd $RUNDIR
STAR --runThreadN 12 --runMode genomeGenerate --genomeDir star --genomeFastaFiles /scratch/cr1636/august/JoinedScaffold --sjdbGTFfile /scratch/cr1636/august/KH.KHGene.2013.gtf
exit 0;
