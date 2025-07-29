#!/bin/bash
#SBATCH --output=/home/a1671704/fastdir/Data_TigerSnake/3_transcriptomeAssembly/cdHITandDeNovo/qualityAssessment/slurm/ExN50_%j.out
#SBATCH --error=/home/a1671704/fastdir/Data_TigerSnake/3_transcriptomeAssembly/cdHITandDeNovo/qualityAssessment/slurm/ExN50_%j.err
#SBATCH --mail-user=a1671704@student.adelaide.edu.au
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=16GB
#SBATCH --time=00:30:00
#SBATCH --partition=batch

TRINITYDIR=/apps/software/Trinity/2.5.1-foss-2016b/trinityrnaseq-Trinity-v2.5.1/util/misc
MATRIXDIR=/home/a1671704/fastdir/Data_TigerSnake/3_transcriptomeAssembly/cdHITandDeNovo/downstreamAnalysis
ASSEMDIR=/home/a1671704/fastdir/Data_TigerSnake/3_transcriptomeAssembly/cdHITandDeNovo
OUTDIR=/home/a1671704/fastdir/Data_TigerSnake/3_transcriptomeAssembly/cdHITandDeNovo/qualityAssessment
${TRINITYDIR}/contig_ExN50_statistic.pl \
  ${MATRIXDIR}/CDHITKallistoAbundance.isoform.TMM.EXPR.matrix \
  ${ASSEMDIR}/collaspedTrinityDeNovo90 | \
  tee ${OUTDIR}/ExN90stats.txt
