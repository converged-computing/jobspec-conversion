#!/bin/bash
#FLUX: --job-name=dlsumtree
#FLUX: -t=1800
#FLUX: --priority=16

CONTAINER=/cluster/tufts/wongjiradlab/larbys/larbys-containers/singularity_ubdl_deps_py2_10022019.simg
FILECHECK_DIR=/cluster/tufts/wongjiradlab/twongj01/dllee-ana/filecheck
GRID_DIR=$FILECHECK_DIR/grid_scripts
SAMPLE=dlmergedsparsessnet_mcc9_v13_nueintrinsics_overlay_run1
module load singularity
singularity exec $CONTAINER bash -c "cd $GRID_DIR && source run_script.sh $SAMPLE $GRID_DIR"
