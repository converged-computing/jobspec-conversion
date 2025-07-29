#!/bin/bash
#SBATCH --job-name=Color_Palette
#SBATCH --account=PAS2136
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

set -e
INPUT_DATA_DIR=$1
OUTPUT_DATA_DIR=$2
if [ ! -d "$INPUT_DATA_DIR" ]
then
   echo "ERROR: Required first positional argument ($INPUT_DATA_DIR) does not exist."
   exit 1
fi
if [ -z "$OUTPUT_DATA_DIR" ]
then
   echo "ERROR: Required second positional argument must have a value."
   exit 1
fi
module load miniconda3/4.10.3-py37
source activate snakemake
BIND_DIR=$(pwd)
snakemake \
    --cores $SLURM_NTASKS \
    --use-singularity \
    --singularity-args "--bind $BIND_DIR:$BIND_DIR" \
    --config data_dir=$INPUT_DATA_DIR \
    --directory $OUTPUT_DATA_DIR
