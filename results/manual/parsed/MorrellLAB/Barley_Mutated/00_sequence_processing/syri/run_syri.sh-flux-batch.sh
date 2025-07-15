#!/bin/bash
#FLUX: --job-name=reclusive-house-4142
#FLUX: --urgency=16

export PATH='${PATH}:/panfs/jay/groups/9/morrellp/shared/Software/syri'

set -e
set -o pipefail
module load python3/3.9.3_anaconda2021.11_mamba
module load gcc/7.2.0
export PATH=${PATH}:/panfs/jay/groups/9/morrellp/shared/Software/syri
PAF_LIST="/panfs/jay/groups/9/morrellp/shared/Datasets/Alignments/morex_v2_to_v3/paf_chr_list_morex_refV3_qryV2_asm5.txt"
REF_FASTA_LIST="/panfs/jay/groups/9/morrellp/shared/References/Reference_Sequences/Barley/Morex_v3/PhytozomeV13_HvulgareMorex_V3/assembly/split_by_chr/chr_fasta_list_HvulgareMorex_702_V3.hardmasked.txt"
QRY_FASTA_LIST="/panfs/jay/groups/9/morrellp/shared/References/Reference_Sequences/Barley/Morex_v2/split_by_chr/chr_fasta_list_Barley_Morex_V2_pseudomolecules.txt"
CHR_ARR=("chr1H" "chr2H" "chr3H" "chr4H" "chr5H" "chr6H" "chr7H")
OUT_DIR="/panfs/jay/groups/9/morrellp/shared/Datasets/Alignments/morex_v2_to_v3/syri_out"
SAMPLE="Morex"
REF_PREFIX="HvMorex_702_V3.hardmasked"
QRY_PREFIX="Morex_V2"
mkdir -p ${OUT_DIR}
MAX_ARRAY_LIMIT=$[${#CHR_ARR[@]} - 1]
echo "Maximum array limit is ${MAX_ARRAY_LIMIT}."
CURR_CHR=${CHR_ARR[${SLURM_ARRAY_TASK_ID}]}
echo "Currently processing chromosome: ${CURR_CHR}"
PAF=$(grep -w "${CURR_CHR}" ${PAF_LIST})
REF_FASTA=$(grep -w "${CURR_CHR}" ${REF_FASTA_LIST})
QRY_FASTA=$(grep -w "${CURR_CHR}" ${QRY_FASTA_LIST})
echo "Current set of files:"
echo "PAF file: ${PAF}"
echo "Reference fasta file: ${REF_FASTA}"
echo "Query fasta file: ${QRY_FASTA}"
OUT_PREFIX=$(printf "${CURR_CHR}_${SAMPLE}-REF.${REF_PREFIX}-QRY.${QRY_PREFIX}.")
syri -c ${PAF} -r ${REF_FASTA} -q ${QRY_FASTA} -k -F P --dir ${OUT_DIR} --prefix ${OUT_PREFIX} --lf syri_${OUT_PREFIX}log
