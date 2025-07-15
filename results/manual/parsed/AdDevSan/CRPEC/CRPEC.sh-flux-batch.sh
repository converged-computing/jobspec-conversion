#!/bin/bash
#FLUX: --job-name=CRPEC
#FLUX: -c=8
#FLUX: --queue=gpu3090
#FLUX: --priority=16

RUNS_DIR="./runs"
SAMPLE_ID="CRPEC_run_$(date +%Y%m%d_%H%M%S)"
TRIDENT_DIRECTORY="input/GSM4909297" #To be hit with the loop on each sample trident directory
LOOP_RUNS=100
bash initialize_directories.sh "${SAMPLE_ID}"
SAMPLE_DIR="${RUNS_DIR}/${SAMPLE_ID}"
python3 trident_preprocess_to_h5ad_barcodes.py -t "${TRIDENT_DIRECTORY}" -hd "${SAMPLE_DIR}" -bd "${SAMPLE_DIR}"
FILTERED_BARCODES="${SAMPLE_DIR}/filtered_barcodes.tsv"
python3 sample_200.py -b "${FILTERED_BARCODES}" -n ${LOOP_RUNS} -s "${SAMPLE_DIR}/sample_200" -r "${SAMPLE_DIR}/sample_remainder"
R preprocess_sc3.R
INITIAL_CLUSTERS_DIR="${RUNS_DIR}/${SAMPLE_ID}/initial_clusters"
REFINED_CLUSTERS_DIR="${RUNS_DIR}/${SAMPLE_ID}/refined_clusters"
H5AD_FILE_PATH="${RUNS_DIR}/${SAMPLE_ID}/h5ad_file.h5ad" # Assuming this is the input file path
bash refine_clusters.sh "${H5AD_FILE_PATH}" "${INITIAL_CLUSTERS_DIR}" "${REFINED_CLUSTERS_DIR}"
