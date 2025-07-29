#!/bin/bash
#FLUX: --job-name=pipeline
#FLUX: -c=16
#FLUX: --queue=<HPC_partition>
#FLUX: --urgency=16

export BINDS='${BINDS},${WORKINGDIR}:${WORKINGDIR}'

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
IMAGE_NAME=rcorrector:1.0.6--h43eeafb_0
if [ -f ${pipedir}/singularities/${IMAGE_NAME} ]; then
    echo "Singularity image exists"
 else
    echo "Singularity image does not exist"
    wget -O ${pipedir}/singularities/${IMAGE_NAME} https://depot.galaxyproject.org/singularity/$IMAGE_NAME
fi
echo ${singularities}
SINGIMAGEDIR=${pipedir}/singularities
SINGIMAGENAME=${IMAGE_NAME}
WORKINGDIR=${pipedir}
export BINDS="${BINDS},${WORKINGDIR}:${WORKINGDIR}"
bases=$(ls ${rawdir}/*_1.fastq.gz | xargs -n 1 basename | sed 's/_1.fastq.gz//' | sort | uniq)
for base in $bases; do
    export base
    # Debug: Print the base name
    echo "Processing base name: $base"
cat >${log}/rcor_taxa_commands_${SLURM_JOB_ID}.sh <<EOF
run_rcorrector.pl -1 ${krakendir}/${base}_1.fastq.gz -2 ${krakendir}/${base}_2.fastq.gz -od ${rcordir} -t ${SLURM_CPUS_PER_TASK}
EOF
singularity exec --contain --bind ${BINDS} --pwd ${WORKINGDIR} ${SINGIMAGEDIR}/${SINGIMAGENAME} bash ${log}/rcor_taxa_commands_${SLURM_JOB_ID}.sh
done
