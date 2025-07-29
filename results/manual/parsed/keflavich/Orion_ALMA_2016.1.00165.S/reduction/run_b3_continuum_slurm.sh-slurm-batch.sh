#!/bin/bash
#SBATCH --account=adamginsburg
#SBATCH --mail-user=adamginsburg@ufl.edu
#SBATCH --mail-type=NONE
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=200gb
#SBATCH --time=12-08:00:00
#SBATCH --qos=adamginsburg

export CASA='/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa'

pwd; hostname; date
module load git
which python
which git
git --version
echo $?
cd /orange/adamginsburg/orion/2016.1.00165.S/imaging
scriptpath=/orange/adamginsburg/orion/Orion_ALMA_2016.1.00165.S/reduction
export CASA=/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa
xvfb-run -d ${CASA}  --nogui --nologger -c "execfile('${scriptpath}/continuum_imaging_b3_sep17_2020.py')"
