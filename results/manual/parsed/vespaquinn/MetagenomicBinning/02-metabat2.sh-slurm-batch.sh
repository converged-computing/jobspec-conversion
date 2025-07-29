#!/bin/bash
#SBATCH --job-name=metabat2
#SBATCH --output=/!!WORKDIR!!/errorOut/metabat2_out.o
#SBATCH --error=/!!WORKDIR!!/errorOut/metabat2_error.e
#SBATCH --mail-user=user@unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=1-12:00:00

workdir=/path/to/workdir                              # < CHANGE
datasets_array=($(<datasets.txt))
metabat2_sif=${workdir}/singularity/metabat2.sif
for dataset in "${datasets_array[@]}"; do
outdir="${workdir}/results/02-MetaBAT2/${dataset}_bins"
contigs="${workdir}/data/assemblies/${dataset}.fa.gz"
bamfile="${workdir}/results/01-indexing/${dataset}_indices/${dataset}_aligned.sorted.bam"
mkdir -p ${outdir}
cd ${outdir}
singularity exec \
--bind ${workdir} \
${metabat2_sif} jgi_summarize_bam_contig_depths --outputDepth ${dataset}_depth.txt ${bamfile}
singularity exec \
--bind ${workdir} \
--bind ${outdir}
${metabat2_sif} metabat2 -t 16 -i ${contigs} -a ${dataset}_depth.txt -o ${outdir}/${dataset}_bin
done
