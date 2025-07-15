#!/bin/bash
#FLUX: --job-name=Medaka
#FLUX: -c=64
#FLUX: --queue=<HPC_partition>
#FLUX: --priority=16

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
IMAGE_NAME=medaka:1.8.0--py39h771796b_0
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
WORKINGDIR=$(pwd -P)
ILLUMINA_BASECALL="/mnt/scratch/c23048124/pipeline_all/workdir/rawdir/leaf/SRR11802588.fastq.gz"
NANOPORE_DRAFT_ASSEMBLY="${moduledir}/polish/racon_polished_assembly.fasta"
OUTPUT_DIR="${moduledir}/polish/medaka_assembly_output"
cat >${log}/medaka_commands_${SLURM_JOB_ID}.sh <<EOF
medaka_consensus -i $ILLUMINA_BASECALL -d $NANOPORE_DRAFT_ASSEMBLY -o $OUTPUT_DIR -m r941_min_high_g303
EOF
singularity exec --contain --bind ${BINDS} --pwd ${WORKINGDIR} ${SINGIMAGEDIR}/${SINGIMAGENAME} bash ${log}/medaka_commands_${SLURM_JOB_ID}.sh
