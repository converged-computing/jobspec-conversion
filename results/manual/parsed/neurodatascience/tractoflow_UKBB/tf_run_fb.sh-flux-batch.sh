#!/bin/bash
#FLUX: --job-name=crusty-muffin-0616
#FLUX: -c=8
#FLUX: -t=72000
#FLUX: --priority=16

export FB='$(printf "%5.5d" ${SLURM_ARRAY_TASK_ID})'
export SINGULARITY_BIND=''

set -eu
export FB=$(printf "%5.5d" ${SLURM_ARRAY_TASK_ID})
export SINGULARITY_BIND=""
TASK_ROOT=/lustre03/project/6008063/atrefo/sherbrooke/TF_RUN
OUT_IMAGE=${TASK_ROOT}/ext3_images/TF_raw/TF-raw-${FB}.img
OUT_ROOT=/TF_OUT/${FB}
SYMTREE="${TASK_ROOT}/ext3_images/symtree.squashfs"
FAKEBIDS="$TASK_ROOT/ext3_images/fakebids.squashfs"
BIDS_DIR="/fakebids/dwi_subs-$FB"
TRACE_DIR="$TASK_ROOT/sanity_out/nf_traces"
TRACE_FILE="$TRACE_DIR/trace-${FB}.txt"
cd $TASK_ROOT || exit
SING_TF_IMAGE=$TASK_ROOT/tractoflow.sif
UKBB_SQUASHFS_DIR=/project/6008063/neurohub/ukbb/imaging
UKBB_SQUASHFS="
  neurohub_ukbb_dwi_ses2_0_bids.squashfs
  neurohub_ukbb_dwi_ses2_1_bids.squashfs
  neurohub_ukbb_dwi_ses2_2_bids.squashfs
  neurohub_ukbb_t1_ses2_0_bids.squashfs
  neurohub_ukbb_t1_ses3_0_bids.squashfs
  neurohub_ukbb_participants.squashfs
  neurohub_ukbb_t1_ses2_0_jsonpatch.squashfs
"
SING_BINDS=" -H ${OUT_ROOT} -B ${TASK_ROOT} -B ${OUT_IMAGE}:${OUT_ROOT}:image-src=/upper "
UKBB_OVERLAYS=$(echo "" $UKBB_SQUASHFS | sed -e "s# # --overlay $UKBB_SQUASHFS_DIR/#g")
DWI_OVERLAYS="--overlay ${SYMTREE},${FAKEBIDS}"
module load singularity/3.7
SINGULARITYENV_NXF_CLUSTER_SEED=$(shuf -i 0-16777216 -n 1) singularity -d exec --cleanenv $SING_BINDS $UKBB_OVERLAYS $DWI_OVERLAYS $SING_TF_IMAGE \
  nextflow -q run /tractoflow/main.nf     \
  --bids          ${BIDS_DIR}             \
  --output_dir    ${OUT_ROOT}             \
  -w              ${OUT_ROOT}/work        \
  --dti_shells    "1 1000"                \
  --fodf_shells   "0 1000 2000"           \
  --step          0.5                     \
  --mean_frf      false                   \
  --set_frf       true                    \
  --save_seeds    false                   \
  -profile        fully_reproducible      \
  -resume                                 \
  -with-trace     ${TRACE_FILE}           \
  --processes     4                       \
  --processes_brain_extraction_t1 1       \
  --processes_denoise_dwi         2       \
  --processes_denoise_t1          2       \
  --processes_eddy                1       \
  --processes_fodf                2       \
  --processes_registration        1       \
