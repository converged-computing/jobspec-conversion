#!/bin/bash
#FLUX: --job-name=plotSCF
#FLUX: -c=18
#FLUX: --queue=biochem,owners,normal
#FLUX: -t=54000
#FLUX: --priority=16

module load python/2.7.13
source $py2env/bin/activate
cpfitted="normed_anyRNA.CPfitted.gz"    # name of CPfitted.gz file from initial fit
cpannot="JL4CY_anyRNA.CPannot.gz"       # name of CPannot file generated and used for fit
plotdir="SCFPlots"                      # name of dir to create and save plots in
mkdir -p $plotdir
python $rnamap_scripts/new_scripts/plotSingleClusterFits.py $cpfitted $cpannot $plotdir
