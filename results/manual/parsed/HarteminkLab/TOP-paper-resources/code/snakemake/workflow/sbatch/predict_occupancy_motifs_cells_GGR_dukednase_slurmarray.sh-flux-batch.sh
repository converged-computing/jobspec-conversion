#!/bin/bash
#FLUX: --job-name=predict_GGR
#FLUX: --urgency=16

module load R/4.1.1-rhel8
METADATA='/datacommons/harteminklab/kl124/TOP/data/GGR/metadata/predictions/GGR_DNase_JASPAR2022NR_all_motifs_predict_data_table.tsv'
MODEL='/datacommons/harteminklab/kl124/TOP/output/TOP_postfit/hg19/OpenChromDnase/JASPARver1/priorVar1/M5/TOP_posterior_mean_coef.rds'
DATADIR='/hpc/home/kl124/work/TOP/processed_GGR_data/dnase_sites_counts/hg38/JASPAR2022'
SITESDIR='/hpc/home/kl124/work/TOP/processed_GGR_data/candidate_sites/hg38/JASPAR2022'
GENOMECOUNTSDIR='/hpc/home/kl124/work/TOP/processed_GGR_data/dnase_genome_counts/hg38'
BAMDIR='/hpc/home/kl124/work/data/GGR/DNase-seq/hg38'
OUTDIR='/hpc/home/kl124/datacommons/TOP/TOP_predictions_202112/hg38/GGR/JASPAR2022'
echo metadata=${METADATA}
echo model=${MODEL}
echo datadir=${DATADIR}
echo sites_dir=${SITESDIR}
echo genomecount_dir=${GENOMECOUNTSDIR}
echo bamdir=${BAMDIR}
echo outdir=${OUTDIR}
tf_list_file='/datacommons/harteminklab/kl124/TOP/data/ENCODE/metadata/predictions/hg38/JASPAR2022_CORE_vertebrates_nr_filtered_TF_motif_table.tsv'
echo "File listing TFs and cell types: ${tf_list_file}"
echo "Run #${SLURM_ARRAY_TASK_ID} on the tf list."
idx_line=${SLURM_ARRAY_TASK_ID}
tf_name=$(awk -v i=${idx_line} -v j=1 'FNR == i {print $j}' ${tf_list_file})
pwm_id=$(awk -v i=${idx_line} -v j=2 'FNR == i {print $j}' ${tf_list_file})
echo "${tf_name}, ${pwm_id}"
cd /hpc/group/harteminklab/kl124/projects/TOP/TOP_workflow/snakemake/workflow/scripts/
start=`date +%s`
Rscript predict_occupancy_motifs_conditions.R \
  --metadata ${METADATA} \
  --tf_list ${tf_name} \
  --model ${MODEL} \
  --data_dir ${DATADIR} \
  --sites_dir ${SITESDIR} \
  --genomecount_dir ${GENOMECOUNTSDIR} \
  --idxstats_dir ${BAMDIR} \
  --ref_size '1e8' \
  --thresh_pValue '1e-5' \
  --bin 'M5' \
  --outdir ${OUTDIR}
end=`date +%s`
runtime=$((end-start))
echo "Run time: ${runtime} seconds"
echo "Results saved at: ${OUTDIR}"
