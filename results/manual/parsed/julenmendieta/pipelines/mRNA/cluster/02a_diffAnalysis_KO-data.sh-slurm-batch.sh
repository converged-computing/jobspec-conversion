#!/bin/bash
#SBATCH --job-name=mRNA_diff-ko
#SBATCH --output=/home/jmendietaes/jobsSlurm/outErr/%x_%A_%a.out
#SBATCH --error=/home/jmendietaes/jobsSlurm/outErr/%x_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=30G
#SBATCH --time=05:00:00

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
