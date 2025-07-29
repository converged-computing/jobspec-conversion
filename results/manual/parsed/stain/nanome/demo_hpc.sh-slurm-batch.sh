#!/bin/bash
#SBATCH --job-name=nanome.human_demo_hpc
#SBATCH --output=log/%x.%j.log
#SBATCH --mail-user=yang.liu@jax.org
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=01:30:00
#SBATCH --partition=inference

set -e
date; hostname; pwd
baseDir=${1:-/fastscratch/$USER/nanome}
pipelineName=${2:-"human_demo"}
rm -rf ${baseDir}/${pipelineName}
mkdir -p ${baseDir}/${pipelineName}
module load singularity
set -x
cd ${baseDir}/${pipelineName}
nextflow run ${NANOME_DIR}\
    -resume -with-report -with-timeline -with-trace -with-dag\
    -profile singularity,hpc\
    -config ${NANOME_DIR}/conf/executors/jaxhpc_input.config\
    --dsname TestData\
    --input https://storage.googleapis.com/jax-nanopore-01-project-data/nanome-input/demo1_fast5_reads.tar.gz\
	--runTombo --runMETEORE --runDeepMod --useDeepModCluster\
	--outputIntermediate --outputRaw\
	--outputGenomeBrowser --outputBam --outputONTCoverage\
	--deduplicate --sort \
	--processors 8
tree work > ${pipelineName}_work_filetree.txt
tree results >  ${pipelineName}_results_filetree.txt
tar -czf ${pipelineName}.tar.gz  \
    ${pipelineName}_results_filetree.txt ${pipelineName}_work_filetree.txt \
    work/*/*/.command.* work/*/*/*.run.log \
    *trace/  .nextflow.log
find  work  -name '*.Report.run.log' -exec tail {} \;
echo "### NANOME pipeline for human_demo data on HPC winter DONE"
