#!/bin/bash
#FLUX: --job-name=pipeline
#FLUX: -c=8
#FLUX: --queue=<HPC_partition>
#FLUX: --urgency=16

export BINDS='${BINDS},${WORKINGFOLDER}:${WORKINGFOLDER}'

echo "Some Usable Environment Variables:"
echo "================================="
echo "hostname=$(hostname)"
echo \$SLURM_JOB_ID=${SLURM_JOB_ID}
echo \$SLURM_NTASKS=${SLURM_NTASKS}
echo \$SLURM_NTASKS_PER_NODE=${SLURM_NTASKS_PER_NODE}
echo \$SLURM_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
echo \$SLURM_JOB_CPUS_PER_NODE=${SLURM_JOB_CPUS_PER_NODE}
echo \$SLURM_MEM_PER_CPU=${SLURM_MEM_PER_CPU}
cat $0
module load singularity/3.8.7
SINGULARITY_IMAGE_NAME=upimapi_1.9.0.sif
if [ -f ${pipedir}/singularities/${SINGULARITY_IMAGE_NAME} ]; then
    echo "Singularity image exists"
else
    echo "Singularity image does not exist"
    cp /mnt/scratch/nodelete/singularity_images/upimapi_1.9.0.sif ${pipedir}/singularities/upimapi_1.9.0.sif
fi
SINGIMAGEDIR=${pipedir}/singularities
SINGIMAGENAME=${SINGULARITY_IMAGE_NAME}
WORKINGFOLDER=${pipedir}
export BINDS="${BINDS},${WORKINGFOLDER}:${WORKINGFOLDER}"
cat >${log}/upimapi_source_commands_${SLURM_JOB_ID}.sh <<EOF
for i in sprot Dmel Cele Mmus Scer Hsap; do
mkdir ${upimapi}/\${i}/
upimapi --blast -i "${blastout}/${assembly}_\${i}_blp.tsv" -t ${SLURM_CPUS_PER_TASK} -o ${upimapi}/\${i}/ -ot "${upimapi}/\${i}/${assembly}_\${i}_upimapi.tsv" --columns "Gene Names&InterPro&PANTHER"
done
EOF
singularity exec --contain --bind ${BINDS} --pwd ${WORKINGFOLDER} ${SINGIMAGEDIR}/${SINGIMAGENAME} bash ${log}/upimapi_source_commands_${SLURM_JOB_ID}.sh
