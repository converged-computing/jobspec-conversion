#!/bin/bash
#SBATCH --job-name=stat_analysis
#SBATCH --output=/work/biocore/zalsafwani/CRC_data/raw_reads/qiime2/second_analysis/stat/script_output/std.out
#SBATCH --error=/work/biocore/zalsafwani/CRC_data/raw_reads/qiime2/second_analysis/stat/script_output/err.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64000
#SBATCH --time=12:00:00
#SBATCH --partition=batch,guest
#SBATCH --constraint=ntasks-per-node=16

module load qiime2/2022.2
cd /work/biocore/zalsafwani/CRC_data/raw_reads/qiime2/second_analysis
qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/faith_pd_vector.qza \
  --m-metadata-file metadata.tsv \
  --o-visualization stat/faiths_pd_statistics.qzv
qiime diversity alpha-group-significance \
 --i-alpha-diversity core-metrics-results/evenness_vector.qza \
 --m-metadata-file metadata.tsv \
 --o-visualization stat/evenness_statistics.qzv
qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/shannon_vector.qza \
  --m-metadata-file metadata.tsv \
  --o-visualization stat/shannon_pd_statistics.qzv 
qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/observed_features_vector.qza \
  --m-metadata-file metadata.tsv \
  --o-visualization stat/observed_features_pd_statistics.qzv 
qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/bray_curtis_distance_matrix.qza \
  --m-metadata-file metadata.tsv \
  --m-metadata-column type \
  --o-visualization stat/bray-curtis-type-significance.qzv
qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/bray_curtis_distance_matrix.qza \
  --m-metadata-file metadata.tsv \
  --m-metadata-column sub-type \
  --o-visualization stat/bray-curtis-sub-type-significance.qzv
qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/jaccard_distance_matrix.qza \
  --m-metadata-file metadata.tsv \
  --m-metadata-column type \
  --o-visualization stat/jaccard-type-significance.qzv
qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/jaccard_distance_matrix.qza \
  --m-metadata-file metadata.tsv \
  --m-metadata-column sub-type \
  --o-visualization stat/jaccard-sub-type-significance.qzv  
qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata.tsv \
  --m-metadata-column type \
  --o-visualization stat/unweighted-unifrac-type-significance.qzv
qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/weighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata.tsv \
  --m-metadata-column sub-type \
  --o-visualization stat/weighted-unifrac-sub-type-significance.qzv
qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/weighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata.tsv \
  --m-metadata-column type \
  --o-visualization stat/weighted-unifrac-type-significance.qzv    
qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata.tsv \
  --m-metadata-column sub-type \
  --o-visualization stat/unweighted-unifrac-sub-type-significance.qzv
