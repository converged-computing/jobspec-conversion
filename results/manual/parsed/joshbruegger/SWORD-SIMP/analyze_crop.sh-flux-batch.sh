#!/bin/bash
#FLUX: --job-name=thesis
#FLUX: -t=1800
#FLUX: --priority=16

echo "Loading modules..."
module purge
module load PyTorch/1.12.1-foss-2022a-CUDA-11.7.0 #3.10.4
module load OpenCV/4.6.0-foss-2022a-contrib #3.10.4
if [ ! -d "$HOME/.envs/thesis_env" ] || [ "$e" = true ] ; then
    echo "Creating virtual environment..."
    # Create the virtual environment
    python3 -m venv $HOME/.envs/thesis_env
fi
echo "Activating virtual environment..."
source $HOME/.envs/thesis_env/bin/activate
echo "Installing requirements..."
pip3 install --upgrade pip
pip3 install -r $SLURM_SUBMIT_DIR/requirements.txt
python3 -u analyze_crops.py /scratch/$USER/dataset/source
