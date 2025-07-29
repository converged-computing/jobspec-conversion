#!/bin/bash
#SBATCH --job-name=MetaAnalysis
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module load jdk/16.0.1
module load openjdk/11.0.2
module load any/singularity
module load squashfs/4.4
nextflow_path=/gpfs/space/GI/eQTLGen/EstBB_testing/MetaAnalysis/tools
set -f
input_path='/gpfs/space/GI/eQTLGen/freeze1/eqtl_mapping/output/empirical_4GenPC20ExpPC_2022-11-14/MetaAnalysisResultsEncoded/node_1_*_result.parquet'
output_folder=../output/MetaAnalysisResultsPartitioned
NXF_VER=21.10.6 ${nextflow_path}/nextflow run OutputPerPhenotype.nf \
--input ${input_path} \
--outdir ${output_folder} \
-resume \
-profile slurm,singularity
