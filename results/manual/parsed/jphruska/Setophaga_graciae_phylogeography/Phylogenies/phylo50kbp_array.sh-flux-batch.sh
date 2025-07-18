#!/bin/bash
#FLUX: --job-name=phylo
#FLUX: -n=2
#FLUX: --queue=quanah
#FLUX: -t=172800
#FLUX: --urgency=16

module load intel java bcftools
module load intel R
PER_TASK=19
START_NUM=$(( ($SLURM_ARRAY_TASK_ID - 1) * $PER_TASK + 1 ))
END_NUM=$(( $SLURM_ARRAY_TASK_ID * $PER_TASK ))
echo This is task $SLURM_ARRAY_TASK_ID, which will do runs $START_NUM to $END_NUM
for (( run=$START_NUM; run<=$END_NUM; run++ )); do
	echo This is SLURM task $SLURM_ARRAY_TASK_ID, run number $run
	chrom_array=$( head -n${run} tree_helper_chrom.txt | tail -n1 )
	start_array=$( head -n${run} tree_helper_start.txt | tail -n1 )
	end_array=$( head -n${run} tree_helper_end.txt | tail -n1 )
	gunzip -cd /lustre/scratch/johruska/setophaga/03_vcf/combined_vcfs/dataset1_phylo/CM027507.1.g.vcf.phylo.filtered.vcf.recode.vcf.gz | grep "#" > /lustre/scratch/johruska/setophaga/03_vcf/combined_vcfs/dataset1_phylo/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf
	tabix /lustre/scratch/johruska/setophaga/03_vcf/combined_vcfs/dataset1_phylo/${chrom_array}.g.vcf.phylo.filtered.recode.vcf.gz ${chrom_array}:${start_array}-${end_array} >> /lustre/scratch/johruska/setophaga/03_vcf/combined_vcfs/dataset1_phylo/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf
	bcftools query -f '%POS\t%REF\t%ALT[\t%GT]\n' /lustre/scratch/johruska/setophaga/03_vcf/combined_vcfs/dataset1_phylo/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf > /lustre/scratch/johruska/setophaga/03_vcf/combined_vcfs/dataset1_phylo/windows/${chrom_array}__${start_array}__${end_array}.simple.vcf
	Rscript create_fasta.r /lustre/scratch/johruska/setophaga/03_vcf/combined_vcfs/dataset1_phylo/windows/${chrom_array}__${start_array}__${end_array}.simple.vcf popmap_phylo.txt
	raxmlHPC-PTHREADS-SSE3 -T 2 -f a -x 50 -m GTRCAT -p 253 -N 100 -s /lustre/scratch/johruska/setophaga/03_vcf/combined_vcfs/dataset1_phylo/windows/${chrom_array}__${start_array}__${end_array}.fasta -n ${chrom_array}__${start_array}__${end_array}.tre -w /lustre/scratch/johruska/setophaga/03_vcf/combined_vcfs/dataset1_phylo/windows/
	rm /lustre/scratch/johruska/setophaga/03_vcf/combined_vcfs/dataset1_phylo/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf
	rm /lustre/scratch/johruska/setophaga/03_vcf/combined_vcfs/dataset1_phylo/windows/${chrom_array}__${start_array}__${end_array}.simple.vcf
	rm /lustre/scratch/johruska/setophaga/03_vcf/combined_vcfs/dataset1_phylo/windows/${chrom_array}__${start_array}__${end_array}.fasta
	rm /lustre/scratch/johruska/setophaga/03_vcf/combined_vcfs/dataset1_phylo/windows/RAxML_bestTree.${chrom_array}__${start_array}__${end_array}.tre
	rm /lustre/scratch/johruska/setophaga/03_vcf/combined_vcfs/dataset1_phylo/windows/RAxML_bipartitionsBranchLabels.${chrom_array}__${start_array}__${end_array}.tre
	rm /lustre/scratch/johruska/setophaga/03_vcf/combined_vcfs/dataset1_phylo/windows/RAxML_info.${chrom_array}__${start_array}__${end_array}.tre
done
