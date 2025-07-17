#!/bin/bash
#FLUX: --job-name=mcskim
#FLUX: --queue=batch
#FLUX: -t=600
#FLUX: --urgency=16

CONTAINER=/cluster/tufts/wongjiradlab/larbys/images/singularity-larflow/singularity-larflow-v2.img
WORKDIR_IC=/cluster/kappa/wongjiradlab/twongj01/dllee-ana/skim_mctruth/
INPUTLIST_IC=/cluster/kappa/wongjiradlab/twongj01/dllee-ana/skim_mctruth/rerunlists/mcc9tag2_nueintrinsic_corsika_dlcosmictaggood.list
OUTDIR_IC=/cluster/kappa/wongjiradlab/twongj01/dllee-ana/skim_mctruth/outdir
module load singularity
singularity exec ${CONTAINER} bash -c "cd ${WORKDIR_IC} && ./job.sh $WORKDIR_IC ${INPUTLIST_IC} ${OUTDIR_IC}"
