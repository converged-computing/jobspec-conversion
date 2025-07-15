#!/bin/bash
#FLUX: --job-name=comp_pract_logdet
#FLUX: -c=24
#FLUX: --queue=savio2
#FLUX: -t=259200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

PYTHON_DIR=$HOME/programs/miniconda3
SCRIPTS_DIR=$(dirname $PWD)/scripts
LOG_DIR=$PWD
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
$PYTHON_DIR/bin/python ${SCRIPTS_DIR}/compare_methods_practical_matrix.py -a -f logdet > ${LOG_DIR}/stream_output_compare_methods_practical_matrix_logdet.txt
