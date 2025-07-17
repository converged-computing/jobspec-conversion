#!/bin/bash
#FLUX: --job-name=Gbull
#FLUX: -c=64
#FLUX: --queue=jumbo
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
cat >${log}/trinity_assembly_commands_${SLURM_JOB_ID}.sh <<EOF
Trinity --seqType fq \
        --left "${rcordir}/Gbull_020823_1.cor.fq.gz" \
        --right "${rcordir}/Gbull_020823_2.cor.fq.gz" \
        --max_memory ${TOTAL_RAM}G \
        --CPU ${SLURM_CPUS_PER_TASK} \
        --output "${assemblydir}/" \
        --full_cleanup
mv "${assemblydir}.Trinity.fasta" "${assemblydir}/${assembly}.fasta"
mv "${assemblydir}.Trinity.fasta.gene_trans_map" "${assemblydir}/${assembly}.gene_trans_map"
sed -i "s/TRINITY_DN/${assembly}_contig_/g" "${assemblydir}/${assembly}.fasta"
/usr/local/bin/util/TrinityStats.pl "${assemblydir}/${assembly}.fasta" > "${assemblydir}/${assembly}_stats.txt"
cp "${assemblydir}/${assembly}.fasta" "${outdir}/${assembly}.fasta"
cp "${assemblydir}/${assembly}_stats.txt" "${outdir}/${assembly}_stats.txt"
cp "${assemblydir}/${assembly}.gene_trans_map" "${outdir}/${assembly}_.gene_trans_map"
echo TOTAL_RAM=${TOTAL_RAM}
echo CPU=${SLURM_CPUS_PER_TASK}
EOF
singularity exec --contain --bind ${BINDS} --pwd ${WORKINGDIR} ${SINGIMAGEDIR}/${SINGIMAGENAME} bash ${log}/trinity_assembly_commands_${SLURM_JOB_ID}.sh
