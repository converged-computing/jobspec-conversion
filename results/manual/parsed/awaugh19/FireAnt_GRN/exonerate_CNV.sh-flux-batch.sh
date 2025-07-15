#!/bin/bash
#FLUX: --job-name=exonerate_CNV
#FLUX: -c=8
#FLUX: --queue=batch
#FLUX: -t=86400
#FLUX: --priority=16

module load Exonerate/2.4.0-GCC-12.2.0
cd /scratch/ahw22099/FireAnt_GRN/Fontana2020_CNV
CNV_genes="/scratch/ahw22099/FireAnt_GRN/Fontana2020_CNV/CNV_genes"
if [ ! -d $CNV_genes ]; then
  mkdir -p $CNV_genes
fi
fasta_num_list=($(<CNV_exo_input_list.txt))
fasta_num=${fasta_num_list[${SLURM_ARRAY_TASK_ID}]}
cd $CNV_genes
num=$(basename "$fasta_num" .fa)
OUTPUT_FILE="${num}_exonerate_output.txt"
exonerate --model est2genome --showtargetgff --showalignment --showvulgar --bestn 5 --query $fasta_num --target /scratch/ahw22099/FireAnt_GRN/Fontana2020_CNV/GCF_016802725.1_UNIL_Sinv_3.0_genomic.fasta --verbose 1 > "$OUTPUT_FILE"
echo "Exonerate alignment for $gene_name completed. Results are saved in $OUTPUT_FILE"
done
