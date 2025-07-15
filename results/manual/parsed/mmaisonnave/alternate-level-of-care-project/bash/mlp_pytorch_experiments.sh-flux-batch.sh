#!/bin/bash
#FLUX: --job-name=mlp_pytorch_experiments
#FLUX: -t=1800
#FLUX: --priority=16

echo Running script at $(pwd)
ENV=pytorch
REPOSITORY_PATH=$(cat ../config/paths.yaml | grep repository\_path: | grep -v ^# | sed 's/^repository\_path:\ //g')
PYTHON_SCRIPTS_FOLDER=src
PYTHON_SCRIPT_NAME=mlp_pytorch_experiments.py
PYTHON_SCRIPT=$REPOSITORY_PATH/$PYTHON_SCRIPTS_FOLDER/$PYTHON_SCRIPT_NAME
echo $(date) - Running python file: $PYTHON_SCRIPT
echo $(date) - Using python: $(python --version)
echo $(date) - Which python: $(which python)
if [ ! -f $PYTHON_SCRIPT ]; then
    echo "Python script not found ($PYTHON_SCRIPT_NAME)"
fi
if [ -z "${VIRTUAL_ENV}" ];
then 
    echo Scripts expect conda environment set "$ENV"
    exit 1
fi
if [ $(echo $VIRTUAL_ENV | sed 's/.*\/\(.*\)$/\1/g' | sed 's/\n\n*//g')  != $ENV ]; 
then 
    echo Scripts expect conda environment set "$ENV"
    exit 1
fi
CUSTOM_COMMAND="$PYTHON_SCRIPT"
echo [RUNNING] python $CUSTOM_COMMAND
python $CUSTOM_COMMAND
