#!/bin/bash
#FLUX: --job-name=blank-peas-8624
#FLUX: -t=7200
#FLUX: --urgency=16

USAGE='PHOTOFOLDER=path/to/photos; sbatch --export=INPUT_FOLDER=$PHOTOFOLDER --job-name=detector-$(basename $PHOTOFOLDER) run_detector.sb'
if [ -z ${PYTHON_FOLDER} ]; then     
    PYTHON_FOLDER=$HOME/python37tf/
    echo "using python folder $PYTHON_FOLDER"
fi
if [ -z "$INPUT_FOLDER" ]; then 
    echo "INPUT_FOLDER variable is required, example slurm command: "
    echo $USAGE
    exit 1
fi
if [ ! -d "$INPUT_FOLDER" ]; then
    echo "Folder not found : $INPUT_FOLDER"
    exit 1
fi
OUTPUT_FOLDER=output/`basename ${INPUT_FOLDER}`
ml purge
ml  GNU/8.2.0-2.31.1 Python/3.7.2  CUDA/10.1.105 cuDNN/7.6.4.38
source $PYTHON_FOLDER/bin/activate
python run_detector.py  $INPUT_FOLDER $OUTPUT_FOLDER
