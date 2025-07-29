#!/bin/bash
#SBATCH --job-name=comp_pract_logdet
#SBATCH --account=fc_biome
#SBATCH --output=output_compare_method_logdet.log
#SBATCH --mail-user=sameli@berkeley.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=3-00:00:00
#SBATCH --qos=savio_normal
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

PYTHON_DIR=$HOME/programs/miniconda3
SCRIPTS_DIR=$(dirname $PWD)/scripts
LOG_DIR=$PWD
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
$PYTHON_DIR/bin/python ${SCRIPTS_DIR}/compare_methods_practical_matrix.py -a -f logdet > ${LOG_DIR}/stream_output_compare_methods_practical_matrix_logdet.txt
