#!/bin/bash
#FLUX: --job-name=lovable-salad-0260
#FLUX: --queue=regular,long7,long30
#FLUX: --priority=16

echo "Workstation is ${HOSTNAME}, partition is ${SLURM_JOB_PARTITION}."
WORKDIR=/workdir/$USER/${SLURM_ARRAY_JOB_ID}-${SLURM_ARRAY_TASK_ID}
DATAHOME=/fs/cbsuclarkfs1/storage/ivc2/turkana
RESULTSHOME=${DATAHOME}/raw-simulations/${SLURM_JOB_NAME}-${SLURM_ARRAY_JOB_ID}
mkdir -p ${WORKDIR}
cd ${WORKDIR}
/programs/bin/labutils/mount_server cbsuclarkfs1 /storage
echo "Copying analysis scripts."
cp -r ~/turkana/* .
echo "Linking SLiM executable."
mkdir bin
ln -s ~/bin/slim3.7 bin/slim3.7
echo "Activating conda environment."
source ~/miniconda3/etc/profile.d/conda.sh
conda activate python39
echo "Running simulations."
snakemake -c1 --use-conda --snakefile 02_simulate.smk "$@" --config slim=bin/slim3.7 normalization_stats=resources/normalization-stats.tsv --conda-prefix ~/turkana-conda
echo "Deactivating conda."
conda deactivate
echo "Moving results into storage."
mkdir -p ${RESULTSHOME}/data
mkdir -p ${RESULTSHOME}/logdata
mkdir -p ${RESULTSHOME}/features
mkdir -p ${RESULTSHOME}/parameters
mkdir -p ${RESULTSHOME}/logs
mkdir -p ${RESULTSHOME}/genotypes
mv output/simulations/data.tar ${RESULTSHOME}/data/data_${SLURM_ARRAY_TASK_ID}.tar
mv output/simulations/logdata.tar ${RESULTSHOME}/logdata/logdata_${SLURM_ARRAY_TASK_ID}.tar
mv output/simulations/features.tar.gz ${RESULTSHOME}/features/features_${SLURM_ARRAY_TASK_ID}.tar.gz
mv output/simulations/parameters.tsv ${RESULTSHOME}/parameters/parameters_${SLURM_ARRAY_TASK_ID}.tsv
tar -czf logs.tar.gz logs/simulations
mv logs.tar.gz ${RESULTSHOME}/logs/logs_${SLURM_ARRAY_TASK_ID}.tar.gz
mv output/simulations/genotypes.tar.gz ${RESULTSHOME}/genotypes/genotypes_${SLURM_ARRAY_TASK_ID}.tar.gz
echo "Cleaning up working directory..."
rm -r $WORKDIR
