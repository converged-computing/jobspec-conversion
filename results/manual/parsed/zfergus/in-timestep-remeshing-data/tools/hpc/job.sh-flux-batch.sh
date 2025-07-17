#!/bin/bash
#FLUX: --job-name=purple-dog-8483
#FLUX: -c=16
#FLUX: -t=604800
#FLUX: --urgency=16

PROJECT_NAME="remeshing-project"
module purge
module load cmake/3.22.2 python/intel/3.8.6 gcc/10.2.0 hdf5/intel/1.12.0
SCRIPTS_ROOT=$HOME/$PROJECT_NAME/scripts
SCRIPT=$(realpath $1)
SCRIPT_REL=$(realpath --relative-to=$SCRIPTS_ROOT $SCRIPT)
OUTPUT_ROOT=$SCRATCH/${PROJECT_NAME}-results
TIME_STAMP=$(date +%Y_%m_%d_%H_%M_%S_%3N)
OUTPUT_DIR="$OUTPUT_ROOT/${SCRIPT_REL%.*}/${TIME_STAMP}"
mkdir -p $OUTPUT_DIR
CODE_DIR=$HOME/polyfem
BIN_DIR=$SCRATCH/polyfem-build/release/
BIN="PolyFEM_bin"
cd $SCRIPTS_ROOT
git rev-parse HEAD > $OUTPUT_DIR/project_commit.txt
git diff > $OUTPUT_DIR/project_diff.patch
cd $CODE_DIR
git rev-parse HEAD > $OUTPUT_DIR/polyfem_commit.txt
git diff > $OUTPUT_DIR/polyfem_diff.patch
cd $BIN_DIR
./$BIN -j $SCRIPT -o $OUTPUT_DIR --log_level debug
