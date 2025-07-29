#!/bin/bash
#SBATCH --mail-user=mailid@illinois.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=126GB
#SBATCH --time=4-00:00:00

source ~/anaconda3/bin/activate daskpy ## This is an example of setting the python virtual environment needed for the code.
echo "#####################################################" ##This is to print any info about the job
echo "# Welcome to the ICON processing script"
echo "#####################################################"
python Aug01.py ##Execute the program
echo "DONE!"
