#!/bin/bash
#SBATCH --job-name=plotSCF
#SBATCH --output=plotSCF.out
#SBATCH --error=plotSCF.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=15:00:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

module load python/2.7.13
source $py2env/bin/activate
cpfitted="normed_anyRNA.CPfitted.gz"    # name of CPfitted.gz file from initial fit
cpannot="JL4CY_anyRNA.CPannot.gz"       # name of CPannot file generated and used for fit
plotdir="SCFPlots"                      # name of dir to create and save plots in
mkdir -p $plotdir
python $rnamap_scripts/new_scripts/plotSingleClusterFits.py $cpfitted $cpannot $plotdir
