#!/bin/bash
#FLUX: --job-name=metabat2
#FLUX: -c=16
#FLUX: -t=129600
#FLUX: --priority=16

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
