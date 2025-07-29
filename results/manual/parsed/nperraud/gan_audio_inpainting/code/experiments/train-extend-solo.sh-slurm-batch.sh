#!/bin/bash
#SBATCH --account=sd01
#SBATCH --output=myexperiment-o-%j.log
#SBATCH --error=myexperiment-e-%j-e.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=23:59:00
#SBATCH --constraint=gpu

module load daint-gpu
module load cray-python
module load TensorFlow/1.14.0-CrayGNU-19.10-cuda-10.1.168-python3
source $HOME/default/bin/activate
cd $HOME/gan_audio_inpainting/code/experiments
srun python myexperiments-extend-solo.py
