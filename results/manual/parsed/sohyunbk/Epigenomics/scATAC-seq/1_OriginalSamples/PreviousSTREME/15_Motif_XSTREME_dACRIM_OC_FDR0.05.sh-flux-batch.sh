#!/bin/bash
#FLUX: --job-name=Meme_motif
#FLUX: --queue=highmem_p
#FLUX: -t=36000
#FLUX: --urgency=16

module load MEME/5.5.0-gompi-2021b
module load BEDTools/2.30.0-GCC-11.3.0
~/.conda/envs/r_env/bin/python /home/sb14489/Epigenomics/scATAC-seq/0_CoreScript/Meme/Generate_null_bedsample_forSTREAM.py \
--bed_file /scratch/sb14489/3.scATAC/2.Maize_ear/11.dACRs/A619_vs_Bif3_BiggerPeaks_AllIntergenic_SeedOn/IM-OC.FDR0.05.Bed \
--genome_file /scratch/sb14489/0.Reference/Maize_B73/Zm-B73-REFERENCE-NAM-5.0_MtPtAdd_Rsf.fa \
--genome_index /scratch/sb14489/0.Reference/Maize_B73/Zm-B73-REFERENCE-NAM-5.0_OnlyChr.fa.fai \
--AllPeakForControl /scratch/sb14489/3.scATAC/2.Maize_ear/7.PeakCalling/Ann_V3_RemoveFakePeak/A619/A619_bif3_For_dACR/IM-OC_ComA619Bif3_BLRemove.bed \
--output_name /scratch/sb14489/3.scATAC/2.Maize_ear/11.dACRs/A619_vs_Bif3_BiggerPeaks_AllIntergenic_SeedOn/IM-OC.FDR0.05_Control.fa \
--Region Within
bash /home/sb14489/Epigenomics/scATAC-seq/0_CoreScript/Motif_Meme_FromACRBed.sh \
--infile_Bed /scratch/sb14489/3.scATAC/2.Maize_ear/11.dACRs/A619_vs_Bif3_BiggerPeaks_AllIntergenic_SeedOn/IM-OC.FDR0.05.Bed \
--Fa /scratch/sb14489/0.Reference/Maize_B73/Zm-B73-REFERENCE-NAM-5.0_MtPtAdd_Rsf.fa \
--MemeMotifDB /scratch/sb14489/3.scATAC/0.Data/Plant_Motif_PWM/JASPAR2022_CORE_plants_non-redundant_pfms_meme.txt \
--ControlFA /scratch/sb14489/3.scATAC/2.Maize_ear/11.dACRs/A619_vs_Bif3_BiggerPeaks_AllIntergenic_SeedOn/IM-OC.FDR0.05_Control.fa \
--OutfilePath /scratch/sb14489/3.scATAC/2.Maize_ear/15.MEME_Motif/IM_OC_dACR_FDR0.05_ControlIMOC_XSTREME
