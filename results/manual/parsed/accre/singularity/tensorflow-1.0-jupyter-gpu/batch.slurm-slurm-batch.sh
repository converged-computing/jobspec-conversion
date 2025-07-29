#!/bin/bash
#SBATCH --account=accre_gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=10G
#SBATCH --time=00:03:00
#SBATCH --partition=maxwell

PORT_NUM=8888
echo "This job will run a Jupyter notebook from within a Singularity image"
echo "To view the notebook, create a new ssh connection to accre with port forwarding:"
echo "ssh -N -L 9999:$hostname:$PORTNUM $USER@login.accre.vanderbilt.edu"
setpkgs -a singularity
singularity run /scratch/singularity-images/tensorflow-1.0-jupyter-gpu.img $PORT_NUM
