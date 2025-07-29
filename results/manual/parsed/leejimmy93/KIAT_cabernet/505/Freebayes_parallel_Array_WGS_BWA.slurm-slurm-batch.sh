#!/bin/bash
#SBATCH --job-name=505_Array_Freebayes
#SBATCH --output=Freebayes_no_pop_%A_%a.out
#SBATCH --error=Freebayes_no_pop_%A_%a.err
#SBATCH --mail-user=rzl0007@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100000
#SBATCH --time=1-00:00:00
#SBATCH --array=1-2

aklog
/bin/hostname
start=`date +%s`
module load freebayes/1.2.0 # I copied /software/freebayes/1.2.0/lssc0-linux/scripts/ to our lab bin and corrected line 40
module load samtools/1.5
module load vcflib/7e3d806
cd /share/malooflab/Ruijuan/505/WGS/mapping_cabernet
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
chrom=`sed "${SLURM_ARRAY_TASK_ID}q;d" chrom_list`
bams=`ls *L003*/${chrom}.bam`
echo ${chrom}
echo ${bams}
bash /share/malooflab/bin/freebayes-parallel <(fasta_generate_regions.py /share/malooflab/John/KIAT/Reference/Split_Chroms/${chrom}.fa.fai 100000) 20 -f /share/malooflab/John/KIAT/Reference/Split_Chroms/${chrom}.fa ${bams} --genotype-qualities --use-best-n-alleles 4 --hwe-priors-off > /share/malooflab/Ruijuan/505/WGS/SNP_parallel_Freebayes_test_HW/${chrom}.vcf
end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
