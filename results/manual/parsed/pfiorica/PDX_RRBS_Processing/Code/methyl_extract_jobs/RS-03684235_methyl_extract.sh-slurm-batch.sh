#!/bin/bash
#SBATCH --job-name=RS-03684235_methyl_extract
#SBATCH --output=logs_bismark/%x.%j.out
#SBATCH --error=logs_bismark/%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=12:00:00
#SBATCH --partition=general-compute
#SBATCH --qos=general-compute
#SBATCH --constraint=ntasks-per-node=1

module load gcc
module load samtools
conda init bash
conda activate bismark
cd $PBS_O_WORKDIR 
bismark_methylation_extractor \
--bedGraph /projects/rpci/joyceohm/pnfioric/RRBS_samfile_links/RS-03684235_001_val_1.fq_trimmed_bismark_bt2_pe.sam \
-o /panasas/scratch/grp-joyceohm/rrbs_methyl_extract/methyl_extract_RS-03684235
