#!/bin/bash
#FLUX: --job-name=sticky-chip-8319
#FLUX: -t=21540
#FLUX: --urgency=16

set -e
ml Java
MEMORY="30G"
CORES=1
BUNDLE_DIR="/groups/umcg-wijmenga/tmp04/projects/depict2/depict2_bundle"
VERSION="51"
TYPE="CORE_GENE_AUC"
DEPICT2="${BUNDLE_DIR}/depict2/Depict2-2.0.${VERSION}-SNAPSHOT/Depict2.jar"
INPUT_FILE=$1
echo "[INFO] Proccesing ${INPUT_FILE}"
CMD="java -Xmx${MEMORY} -XX:ParallelGCThreads=${CORES} -jar ${DEPICT2} \
-m ${TYPE} \
-g ${BUNDLE_DIR}/output/height_paper/${INPUT_FILE}_${VERSION}/${INPUT_FILE}_intermediates/Coregulation_Enrichment_zscoreExHla \
-o ${BUNDLE_DIR}/output/height_paper/${INPUT_FILE}_${VERSION}/${INPUT_FILE}_intermediates/${INPUT_FILE}_coreGene_hpoAUC \
-pd hpo=${BUNDLE_DIR}/reference_datasets/human_b37/hpo/PhenotypeToGenes.txt_matrix.txt"
eval $CMD
CMD="java -Xmx${MEMORY} -XX:ParallelGCThreads=${CORES} -jar ${DEPICT2} \
-m ${TYPE} \
-g ${BUNDLE_DIR}/output/height_paper/${INPUT_FILE}_${VERSION}/${INPUT_FILE}_genePvalues \
-o ${BUNDLE_DIR}/output/height_paper/${INPUT_FILE}_${VERSION}/${INPUT_FILE}_intermediates/${INPUT_FILE}_genePvalue_hpoAUC \
-pd hpo=${BUNDLE_DIR}/reference_datasets/human_b37/hpo/PhenotypeToGenes.txt_matrix.txt"
eval $CMD
CMD="java -Xmx${MEMORY} -XX:ParallelGCThreads=${CORES} -jar ${DEPICT2} \
-m CONVERT_BIN \
-g ${BUNDLE_DIR}/output/height_paper/${INPUT_FILE}_${VERSION}/${INPUT_FILE}_genePvalues \
-o ${BUNDLE_DIR}/output/height_paper/${INPUT_FILE}_${VERSION}/${INPUT_FILE}_genePvalues"
eval $CMD
