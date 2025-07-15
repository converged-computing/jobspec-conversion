#!/bin/bash
#FLUX: --job-name=faux-arm-9907
#FLUX: --urgency=16

set -e
set -o pipefail
module load parallel
module load python3/3.8.3_anaconda2020.07_mamba
source activate /home/morrellp/liux1299/.conda/envs/bad_mutations
PREDICT_DIR_LIST="/scratch.global/liux1299/bad_mutations/predict_output_hybrid_common/predict_out_dir_list.txt"
LONG_SUBS_FILE="/panfs/jay/groups/9/morrellp/shared/Projects/Mutant_Barley/results/bad_mutations/vep_to_subs-hybrid13/per_transcript_subs-hybrid_SNPs_common/hybrid13.SNPs.common_long_subs.txt"
PROJECT="hybrid_common"
OUT_DIR="/panfs/jay/groups/9/morrellp/shared/Projects/Mutant_Barley/results/bad_mutations/predictions"
BAD_MUT_SCRIPT="/panfs/jay/groups/9/morrellp/liux1299/Software/BAD_Mutations/BAD_Mutations.py"
COMPILE_SCRIPT="/panfs/jay/groups/9/morrellp/liux1299/GitHub/Barley_Mutated/02_analysis/bad_mutations/bad_mut_compile_predictions.sh"
${COMPILE_SCRIPT} \
    ${PREDICT_DIR_LIST} \
    ${LONG_SUBS_FILE} \
    ${PROJECT} \
    ${OUT_DIR} \
    ${BAD_MUT_SCRIPT}
