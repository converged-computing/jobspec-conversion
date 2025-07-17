#!/bin/bash
#FLUX: --job-name=purple-leader-6918
#FLUX: --queue=ram256g,ram1t,amdsmall,amdlarge,amd512,amd2tb
#FLUX: -t=10800
#FLUX: --urgency=16

set -e
set -o pipefail
module load minimap2_ML/2.24-r1122
REF_CHR_FA_LIST="/panfs/jay/groups/9/morrellp/shared/References/Reference_Sequences/Barley/Morex_v3/PhytozomeV13_HvulgareMorex_V3/assembly/split_by_chr/chr_fasta_list_HvulgareMorex_702_V3.hardmasked.txt"
QUERY_CHR_FA_LIST="/panfs/jay/groups/9/morrellp/shared/References/Reference_Sequences/Barley/Morex_v2/split_by_chr/chr_fasta_list_Barley_Morex_V2_pseudomolecules.txt"
OUT_PREFIX="Morex_refV3_qryV2_asm5"
CHR_ARR=("chr1H" "chr2H" "chr3H" "chr4H" "chr5H" "chr6H" "chr7H")
OUT_DIR="/panfs/jay/groups/9/morrellp/shared/Datasets/Alignments/morex_v2_to_v3"
N_THREADS="8"
mkdir -p ${OUT_DIR}
MAX_ARRAY_LIMIT=$[${#CHR_ARR[@]} - 1]
echo "Maximum array limit is ${MAX_ARRAY_LIMIT}."
CURR_CHR=${CHR_ARR[${SLURM_ARRAY_TASK_ID}]}
echo "Currently processing chromosome: ${CURR_CHR}"
REF_FA=$(grep -w "${CURR_CHR}" ${REF_CHR_FA_LIST})
QRY_FA=$(grep -w "${CURR_CHR}" ${QUERY_CHR_FA_LIST})
echo "Current set of files:"
echo "Reference fasta file: ${REF_FA}"
echo "Query fasta file: ${QRY_FA}"
minimap2 -cx asm5 --cs -t ${N_THREADS} -r2k --eqx ${REF_FA} ${QRY_FA} > ${OUT_DIR}/${OUT_PREFIX}-${CURR_CHR}.paf
