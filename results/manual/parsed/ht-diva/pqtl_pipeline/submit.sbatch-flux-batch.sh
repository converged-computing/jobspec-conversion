#!/bin/bash
#FLUX: --job-name=pqtl_pipeline
#FLUX: --queue=cpuq
#FLUX: -t=172800
#FLUX: --urgency=16

source ~/.bashrc
module -s load singularity/3.8.5
case $(hostname) in
  hnode*)
    export SINGULARITY_TMPDIR=/tmp/
    export SINGULARITY_BIND="/cm,/exchange,/processing_data,/project,/scratch,/center,/group,/facility,/ssu"
    ;;
  cnode*|gnode*)
    export SINGULARITY_TMPDIR=$TMPDIR
    export SINGULARITY_BIND="/cm,/exchange,/processing_data,/project,/localscratch,/scratch,/center,/group,/facility,/ssu"
    ;;
  lin-hds-*)
    export SINGULARITY_TMPDIR=/tmp/
    export SINGULARITY_BIND="/processing_data,/project,/center,/group,/facility,/ssu,/exchange"
    ;;
  *)
    export SINGULARITY_TMPDIR=/var/tmp/
    ;;
esac
cd /scratch/$USER
mkdir -p pqtl_pipeline
cd pqtl_pipeline
PROJECT_NAME="test"
if [ ! -d ${PROJECT_NAME} ]; then
  git clone --recurse-submodules https://github.com/ht-diva/pqtl_pipeline.git ${PROJECT_NAME}
fi
cd ${PROJECT_NAME}
mkdir -p data
rsync -avz /exchange/healthds/pQTL/pQTL_workplace/TEST_INTERVAL/BATCH/INTERVAL_NonImp_residuals_final.txt data/
rsync -avz /exchange/healthds/public_data/gwaslab_reference_dataset/* data/
rsync -avz /exchange/healthds/public_data/reference_genomes/GRCh37/GCA_000001405.14_GRCh37.p13_full_analysis_set.fna data/
conda activate /exchange/healthds/software/envs/snakemake
make run
