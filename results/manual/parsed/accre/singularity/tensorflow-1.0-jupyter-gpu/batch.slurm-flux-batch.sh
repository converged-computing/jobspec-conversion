#!/bin/bash
#FLUX: --job-name=purple-motorcycle-6924
#FLUX: --queue=maxwell
#FLUX: -t=180
#FLUX: --urgency=16

PORT_NUM=8888
echo "This job will run a Jupyter notebook from within a Singularity image"
echo "To view the notebook, create a new ssh connection to accre with port forwarding:"
echo "ssh -N -L 9999:$hostname:$PORTNUM $USER@login.accre.vanderbilt.edu"
setpkgs -a singularity
singularity run /scratch/singularity-images/tensorflow-1.0-jupyter-gpu.img $PORT_NUM
