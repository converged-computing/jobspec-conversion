#!/bin/bash
#FLUX: --job-name=mRNA_diff-ko
#FLUX: -c=8
#FLUX: --queue=short
#FLUX: -t=18000
#FLUX: --urgency=16

basePath=$1
projectName=$2
outpath=${basePath}"/furtherAnalysis/${projectName}"
salmonOut=${outpath}/counts
subScripts="/home/jmendietaes/programas/pipelines/mRNA/cluster/sub-scripts"
posibleControls="NTC,WT,NTC0005,NtC5,V12h"
R="/home/jmendietaes/programas/miniconda3/envs/Renv/bin/Rscript"
nCPU=$SLURM_CPUS_PER_TASK
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT
echo -e "Starting Diff analysis ---------------------------------------------\n"
mkdir -p ${outpath}/DESeq2_batchCorrect 
${R} ${subScripts}/02a_NR_DESeq2_KO-diffExpr.r \
                    --countTable ${salmonOut}/tximportMerge.gene_counts.tsv \
                    --outdir ${outpath}/DESeq2_batchCorrect/ \
                    --outprefix "RNA_DESeq2"\
                    --cores ${nCPU} \
                    --controls ${posibleControls}
mkdir -p ${outpath}/DESeq2_batchCorrect/gatheredDESeq
cd ${outpath}/DESeq2_batchCorrect/gatheredDESeq
ln -s ../*results* . ; 
echo -e "END ------------------------------------------------------------------"
seff $SLURM_JOBID
exit 0
