#!/bin/bash
#SBATCH --job-name=maxbin2
#SBATCH --output=/!!WORKDIR!!/errorOut/maxbin2out1.o
#SBATCH --error=/!!WORKDIR!!/errorOut/maxbin2error1.e
#SBATCH --mail-user=user@unibe.ch
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=2-00:00:00

workdir=/path/to/workdir                              # < CHANGE
datasets_array=($(<datasets.txt))
for dataset in "${datasets_array[@]}"; do
outdir="${workdir}/results/03-MaxBin2/${dataset}_bins"
contigs="${workdir}/data/assemblies/${dataset}.fa.gz"
bamfile="${workdir}/results/01-indexing/${dataset}_aligned.sorted.bam"
depthfile="${workdir}/results/02-MetaBAT2/${dataset}_bins/${dataset}_depth.txt"
maxbin2_sif="${workdir}/singularity/maxbin2.sif"
mkdir -p ${outdir}
cd ${outdir}
singularity exec \
--bind ${outdir} \
--bind ${depthfile} \
--bind ${contigs} \
--bind ${workdir} \
${maxbin2_sif} run_MaxBin.pl -contig ${contigs} -abund ${depthfile} -out ${outdir}/${dataset}_maxbin2 -thread 16
done
