#!/bin/bash
#FLUX: --job-name=reclusive-leader-2654
#FLUX: -c=8
#FLUX: -t=72000
#FLUX: --urgency=16

export FB='$1'
export SINGULARITY_BIND=''

set -eu
 if test $# -lt 1 ; then
    echo "Usage: $0 [XXXXX] where XXXXX is a number from 00000 - 10000"
    echo "      corresponding to the fake_BIDS directory name"
     exit 2
   fi
export FB=$1
export SINGULARITY_BIND=""
TASK_ROOT=/lustre03/project/6008063/atrefo/sherbrooke/TF_RUN
OUT_IMAGE=${TASK_ROOT}/ext3_images/TF_raw/TF-raw-${FB}.img
OUT_ROOT=/TF_OUT/${FB}
SYMTREE=${TASK_ROOT}/ext3_images/symtree.squashfs
BIDS_DIR="$TASK_ROOT/fake_bids/dwi_subs-${FB}"
TRACE_DIR="$TASK_ROOT/sanity_out/nf_traces"
TRACE_FILE="$TRACE_DIR/trace-${FB}.txt"
cd $TASK_ROOT || exit
cd $BIDS_DIR || exit
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
SING_BINDS=" -H ${OUT_ROOT} -B ${TASK_ROOT} -B ${OUT_IMAGE}:${OUT_ROOT}:image-src=/upper,ro "
UKBB_OVERLAYS=$(echo "" $UKBB_SQUASHFS | sed -e "s# # --overlay $UKBB_SQUASHFS_DIR/#g")
DWI_OVERLAYS="--overlay ${SYMTREE}"
module load singularity/3.7
SINGULARITYENV_NXF_CLUSTER_SEED=$(shuf -i 0-16777216 -n 1) singularity -d shell --cleanenv $SING_BINDS $UKBB_OVERLAYS $DWI_OVERLAYS $SING_TF_IMAGE \
