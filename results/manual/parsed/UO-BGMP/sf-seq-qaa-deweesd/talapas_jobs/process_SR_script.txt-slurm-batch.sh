#!/bin/bash
#FLUX: --job-name=PS_trimmed_data
#FLUX: --queue=gpu
#FLUX: -t=12600
#FLUX: --urgency=16

module purge
module load slurm easybuild intel/2017a Stacks/1.46
process_shortreads -P -i fastq -1 /home/daned/bi624/ps1/8_2F_fox_S7_L008_R1_001.fastq 
-2 /home/daned/bi624/ps1/8_2F_fox_S7_L008_R2_001.fastq 
-o /home/daned/bi624/ps1/trimmed_data 
--adapter_1 AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC --adapter_2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --adapter_mm 2
process_shortreads -P -i fastq -1 /home/daned/bi624/ps1/31_4F_fox_S22_L008_R1_001.fastq -2 /home/daned/bi624/ps1/31_4F_fox_S22_L008_R2_001.fastq 
-o /home/daned/bi624/ps1/output 
--adapter_1 AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC --adapter_2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --adapter_mm 2
