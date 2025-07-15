#!/bin/bash
#FLUX: --job-name=moving_pictures
#FLUX: -n=5
#FLUX: --queue=lrgmem
#FLUX: -t=259200
#FLUX: --priority=16

module load qiime2/2018.8
source ../config_files/moving_picture_analysis.config
echo "Starting moving picture tutorial analysis"
date
echo "Starting alignment and tree"
date
qiime phylogeny align-to-tree-mafft-fasttree --i-sequences ${REPS} --p-n-threads 0 --o-alignment ${PREFIX}_aligned-rep-seqs.qza --o-masked-alignment ${PREFIX}_masked-aligned-rep-seqs.qza --o-tree ${PREFIX}_unrooted-tree.qza --o-rooted-tree ${PREFIX}_rooted-tree.qza
echo "Starting alpha diversity"
date
qiime diversity core-metrics-phylogenetic \
  --i-phylogeny ${PREFIX}_rooted-tree.qza \
  --i-table ${TABLE} \
  --p-sampling-depth ${DEPTH} \
  --m-metadata-file ${METADATA} \
  --output-dir ${PREFIX}_core-metrics-results
echo "Starting alpha diversity significance"
date
qiime diversity alpha-group-significance \
  --i-alpha-diversity ${PREFIX}_core-metrics-results/faith_pd_vector.qza \
  --m-metadata-file ${METADATA} \
  --o-visualization ${PREFIX}_core-metrics-results/faith-pd-group-significance.qzv
qiime diversity alpha-group-significance \
  --i-alpha-diversity ${PREFIX}_core-metrics-results/evenness_vector.qza \
  --m-metadata-file ${METADATA} \
  --o-visualization ${PREFIX}_core-metrics-results/evenness-group-significance.qzv
echo "Beta diversity"
date
qiime emperor plot \
  --i-pcoa ${PREFIX}_core-metrics-results/unweighted_unifrac_pcoa_results.qza \
  --m-metadata-file ${METADATA} \
  --o-visualization ${PREFIX}_core-metrics-results/unweighted-unifrac-emperor.qzv
qiime emperor plot \
  --i-pcoa ${PREFIX}_core-metrics-results/bray_curtis_pcoa_results.qza \
  --m-metadata-file ${METADATA} \
  --o-visualization ${PREFIX}_core-metrics-results/bray-curtis-emperor-days.qzv
echo "Alpha rarefaction"
date
qiime diversity alpha-rarefaction \
  --i-table ${TABLE} \
  --i-phylogeny ${PREFIX}_rooted-tree.qza \
  --p-max-depth ${DEPTH} \
  --m-metadata-file ${METADATA} \
  --o-visualization ${PREFIX}_alpha-rarefaction.qzv
echo "Starting taxonomic analysis"
date
qiime feature-classifier classify-sklearn \
  --i-classifier ${CLASSI} \
  --i-reads ${REPS} \
  --o-classification ${PREFIX}_taxonomy.qza
qiime metadata tabulate \
  --m-input-file ${PREFIX}_taxonomy.qza \
  --o-visualization ${PREFIX}_taxonomy.qzv
qiime taxa barplot \
	--i-table ${TABLE} \
	--i-taxonomy ${PREFIX}_taxonomy.qza \
	--m-metadata-file ${METADATA} \
	--o-visualization ${PREFIX}_taxonomy_barplots.qzv
echo "End of script"
date
