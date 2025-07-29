#!/bin/bash
#SBATCH --job-name=simulate_data
#SBATCH --output=slurmout/simulate_data_%A_%a.out
#SBATCH --error=slurmout/simulate_data_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=9
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=9000
#SBATCH --time=15:00:00

start=`date +%s`
echo $HOSTNAME
length=250
bbmap_dir='/share/biocore/keith/benchmarking/tools/bbmap'
reference='References/GRCh38.primary_assembly.genome.fa'
outdir='01-GoldStandard/human_genome/'
${bbmap_dir}/./randomreads.sh ref=${reference} out1='${outdir}/human_genome1.fastq.gz' out2='${outdir}/human_genome2.fastq.gz' length=$length reads=500000 paired=t
end=`date +%s`
runtime=$((end-start))
echo $runtime
