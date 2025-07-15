#!/bin/bash
#FLUX: --job-name=evasive-bits-9284
#FLUX: -c=16
#FLUX: -t=345600
#FLUX: --priority=16

module purge
module load cmake/3.22.2 python/intel/3.8.6 gcc/10.2.0 hdf5/intel/1.12.0
SCRIPTS_ROOT=$SCRATCH/decoupled-contact/scripts
SCRIPT=$(realpath $1)
SCRIPT_REL=$(realpath --relative-to=$SCRIPTS_ROOT $SCRIPT)
OUTPUT_ROOT=$SCRATCH/decoupled-contact/results
OUTPUT_DIR="$OUTPUT_ROOT/${SCRIPT_REL%.*}"
cd $SCRATCH/polyfem/build/release
./PolyFEM_bin -j $SCRIPT -o $OUTPUT_DIR --ngui --log_level debug
