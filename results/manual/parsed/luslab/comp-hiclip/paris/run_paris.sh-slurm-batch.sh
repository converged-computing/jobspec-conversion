#!/bin/bash
#SBATCH --job-name=comp_paris
#SBATCH --output=comp_paris-%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

ml purge
ml Nextflow/20.10.0
ml Singularity/3.6.4
ml Graphviz/2.38.0-foss-2016b
PROJ=/camp/lab/luscomben/home/users/chakraa2/projects/comp_hiclip
mkdir -p $PROJ/results_paris
nextflow pull amchakra/tosca -r main
nextflow run amchakra/tosca -r main \
-resume \
-profile crick,conda \
--org comp_hiclip \
--input paris_umi.csv \
--outdir $PROJ/results_paris \
--umi_separator _ \
--dedup_method none \
--percent_overlap 0.5 \
--atlas true \
--transcript_fa $PROJ/ref/GRCh38.gencode_v33.fa \
--transcript_fai $PROJ/ref/GRCh38.gencode_v33.fa.fai \
--transcript_gtf $PROJ/ref/GRCh38.gencode_v33.tx.gtf.gz \
--star_args '--limitOutSJcollapsed 5000000'
