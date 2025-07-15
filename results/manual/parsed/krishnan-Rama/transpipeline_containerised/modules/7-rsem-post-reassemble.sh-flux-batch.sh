#!/bin/bash
#FLUX: --job-name=pipeline
#FLUX: -c=4
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
cat >${log}/trinity_postanalysis_commands_${SLURM_JOB_ID}.sh <<EOF
cd ${rsemdir}
isoform_counts=\$(ls "${rsemdir}/"*"/RSEM.isoforms.results")
\$TRINITY_HOME/util/abundance_estimates_to_matrix.pl \
               --gene_trans_map "${assemblydir}/${assembly}_okay.gene_trans_map" \
               --name_sample_by_basedir --est_method RSEM \${isoform_counts} \
               --out_prefix "${rsemdir}/${assembly}_RSEM"
\$TRINITY_HOME/util/misc/count_matrix_features_given_MIN_TPM_threshold.pl "${rsemdir}/${assembly}_RSEM.gene.TPM.not_cross_norm" | tee "${rsemdir}/${assembly}_RSEM.qgenes_matrix.TPM.not_cross_norm.counts_by_min_TPM"
\$TRINITY_HOME/Analysis/DifferentialExpression/PtR --matrix "${rsemdir}/${assembly}_RSEM.gene.counts.matrix" --samples "${metadata}" --CPM --log2 --compare_replicates
\$TRINITY_HOME/Analysis/DifferentialExpression/PtR --matrix "${rsemdir}/${assembly}_RSEM.gene.counts.matrix" -s "${metadata}" --log2 --sample_cor_matrix
\$TRINITY_HOME/Analysis/DifferentialExpression/PtR --matrix "${rsemdir}/${assembly}_RSEM.gene.counts.matrix" -s "${metadata}" --log2 --prin_comp 3
\$TRINITY_HOME/Analysis/DifferentialExpression/run_DE_analysis.pl --matrix "${rsemdir}/${assembly}_RSEM.gene.counts.matrix" --samples_file "${metadata}" --method edgeR --output edgeR_results
\$TRINITY_HOME/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix "${rsemdir}/${assembly}_RSEM.gene.counts.matrix" -P 1e-3 -C 1.4 --samples "${metadata}"
mv "${pipedir}/${assembly}_RSEM"* ${rsem}/
mv "${pipedir}/edgeR_results ${rsem}/
echo TOTAL_RAM=${TOTAL_RAM}
echo CPU=${SLURM_CPUS_PER_TASK}
EOF
singularity exec --contain --bind ${BINDS} --pwd ${WORKINGDIR} ${SINGIMAGEDIR}/${SINGIMAGENAME} bash ${log}/trinity_postanalysis_commands_${SLURM_JOB_ID}.sh
