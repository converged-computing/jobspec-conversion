#!/bin/bash
#FLUX: --job-name=multi_run_task
#FLUX: --queue=gpu
#FLUX: -t=108000
#FLUX: --urgency=16

DATASET=$1
NUM_OF_RUNS=${2:-30}
PARENT_DIR="all_results"
module purge
module load gpu
module load slurm		
module load singularitypro/3.9
module load anaconda3
ENV_NAME="con_jigsaw_env"
if { conda env list | grep $ENV_NAME; } >/dev/null 2>&1; then
    echo "Conda environment for jigsaw already exists"
    echo "Activating conda environment for jigsaw"
else
    echo "Creating conda environment for jigsaw"
    conda create --name $ENV_NAME --file conda_requisites.txt
fi
conda init --all
source ~/.bash_profile
source ~/.bashrc 
conda activate $ENV_NAME
if [ ! -d "data" ]; then
    echo "data folder does not exist, please create the folder and place necessary dataset files."
    echo "Available at: https://github.com/jmoraga-mines/jigsawhsi#requisites"
    echo "Exiting..."
    exit 1;
fi
for ((i=1; i<=$NUM_OF_RUNS; i++)) do
    echo "Running run $i"
    # this will be the output folder for this run
    OUTPUT_DIR="${PARENT_DIR}/${DATASET}/"
    mkdir -p $OUTPUT_DIR
    # the output file will be named 'result.txt'
    OUTPUT_FILE="${OUTPUT_DIR}/${i}.txt"
    # get the process id
    PID=$$
    srun python jigsaw_org.py $DATASET > $OUTPUT_FILE
    # remove the core dump file
    rm -f "core.*"
done
