#!/bin/bash
#FLUX: --job-name=TrimTest
#FLUX: -t=72000
#FLUX: --priority=16

java -jar /home/mkm44/Programs/trinityrnaseq-2.1.1/trinity-plugins/Trimmomatic/trimmomatic.jar PE -phred33 /scratch/users/mkm44/Multispecies/LO03_03_R_75_P1_1.fq /scratch/users/mkm44/Multispecies/LO03_03_R_75_P1_2.fq /scratch/users/mkm44/Multispecies/30bp/30bp_LO03_03_R_75_P1_TrimClip_forward_paired.fq /scratch/users/mkm44/Multispecies/30bp/30bp_LO03_03_R_75_P1_TrimClip_forward_unpaired.fq /scratch/users/mkm44/Multispecies/30bp/30bp_LO03_03_R_75_P1_TrimClip_reverse_paried.fq /scratch/users/mkm44/Multispecies/30bp/30bp_LO03_03_R_75_P1_TrimClip_reverse_unpaired.fq ILLUMINACLIP:/home/mkm44/Programs/trinityrnaseq-2.1.1/trinity-plugins/Trimmomatic/adapters/Truseq2_Palumbi_Index.fasta:2:30:10 SLIDINGWINDOW:4:20 LEADING:10 TRAILING:10 MINLEN:30
