#!/bin/bash
#FLUX: --job-name=pipeline
#FLUX: -c=16
#FLUX: --queue=mammoth
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
IMAGE_NAME=trinityrnaseq/trinityrnaseq:2.15.1
SINGULARITY_IMAGE_NAME=trinityrnaseq_2.15.1.sif
if [ -f ${pipedir}/singularities/${SINGULARITY_IMAGE_NAME} ]; then
    echo "Singularity image exists"
else
    echo "Singularity image does not exist"
    singularity pull ${pipedir}/singularities/${SINGULARITY_IMAGE_NAME} docker://$IMAGE_NAME
fi
echo ${singularities}
SINGIMAGEDIR=${pipedir}/singularities
SINGIMAGENAME=${SINGULARITY_IMAGE_NAME}
TOTAL_RAM=$(expr ${SLURM_MEM_PER_NODE} / 1024)
WORKINGDIR=${pipedir}
export BINDS="${BINDS},${WORKINGDIR}:${WORKINGDIR}"
cat >${log}/trinity_mapping_commands_${SLURM_JOB_ID}.sh <<EOF
file=$(ls ${trimdir}/*_1.fastq.gz | sed -n ${SLURM_ARRAY_TASK_ID}p)
R1=\$(basename \$file | cut -f1 -d.)
base=\$(echo \$R1 | sed 's/_1$//')
mkdir ${assemblydir}/\${base}
cp ${assemblydir}/${assembly}_okay.fasta ${assemblydir}/\${base}/${assembly}_okay.fasta
cp ${assemblydir}/${assembly}_okay.gene_trans_map ${assemblydir}/\${base}/${assembly}_okay.gene_trans_map
\$TRINITY_HOME/util/align_and_estimate_abundance.pl \
     --transcripts ${assemblydir}/\${base}/${assembly}_okay.fasta \
     --seqType fq \
     --left "${trimdir}/\${base}_1.fastq.gz" \
     --right "${trimdir}/\${base}_2.fastq.gz" \
     --est_method RSEM \
     --aln_method bowtie2 \
     --trinity_mode \
     --thread_count ${SLURM_CPUS_PER_TASK} \
     --prep_reference \
     --bowtie2_RSEM "--no-mixed --no-discordant --gbar 1000 -k 200 --end-to-end -N 1 --mp 4" \
      --output_dir ${rsemdir}/\${base}
rm -r ${assemblydir}/\${base}/
EOF
singularity exec --contain --bind ${BINDS} --pwd ${WORKINGDIR} ${SINGIMAGEDIR}/${SINGIMAGENAME} bash ${log}/trinity_mapping_commands_${SLURM_JOB_ID}.sh
