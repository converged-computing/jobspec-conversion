#!/bin/bash
#FLUX: --job-name=placid-buttface-1678
#FLUX: -n=20
#FLUX: --queue=node
#FLUX: -t=345600
#FLUX: --urgency=16

source ~/anaconda3/bin/activate daskpy ## This is an example of setting the python virtual environment needed for the code.
echo "#####################################################" ##This is to print any info about the job
echo "# Welcome to the ICON processing script"
echo "#####################################################"
python Aug01.py ##Execute the program
echo "DONE!"
