#!/bin/bash
#FLUX: --job-name="hic2mcool"
#FLUX: -c=2
#FLUX: --queue=all
#FLUX: -t=18000
#FLUX: --priority=16

export LANGUAGE='en_US:en'
export LANG='C'
export LC_CTYPE='en_US.UTF-8'

source ./envSettings.sh
export LANGUAGE="en_US:en"
export LANG="C"
export LC_CTYPE="en_US.UTF-8"
let i=${SLURM_ARRAY_TASK_ID}-1
sampleName=${samples[i]}
echo $WORK_DIR
if [[ ! -d "${WORK_DIR}/cool" ]] 
then
  mkdir -p ${WORK_DIR}/cool
  mkdir -p ${WORK_DIR}/mcool
fi
if [[ ! -f "${WORK_DIR}/hicpro2higlass.sh" ]]
then
  singularity exec $HICPRO_SIMG cp $HICPRO_UTILS/hicpro2higlass.sh ${WORK_DIR}/
fi
${WORK_DIR}/hicpro2higlass.sh -i ${WORK_DIR}/results/hic_results/matrix/${sampleName}/raw/${res}/${sampleName}_${res}.matrix -r ${res} -c ${GENOME_DIR}/ce11.chrom.sizes -p $SLURM_CPUS_PER_TASK -n -o ${WORK_DIR}/cool
rm ${WORK_DIR}/cool/${sampleName}_${res}.mcool
echo "making mcools file from cool file..."
cooler zoomify --balance --balance-args '--convergence-policy store_nan' -n $SLURM_CPUS_PER_TASK -o ${WORK_DIR}/mcool/${sampleName}_${res}_ice.mcool -c 10000000 -r '2000,4000,10000,20000,50000,100000,200000,500000'  ${WORK_DIR}/cool/${sampleName}_${res}.cool
echo "making raw mcool file from cool file..."
cooler zoomify -n $SLURM_CPUS_PER_TASK -o ${WORK_DIR}/mcool/${sampleName}_${res}_raw.mcool -c 10000000 -r '2000,4000,10000,20000,50000,100000,200000,500000'  ${WORK_DIR}/cool/${sampleName}_${res}.cool
