#!/bin/bash
#FLUX: --job-name=FFmax
#FLUX: -c=8
#FLUX: --queue=biochem,owners,normal
#FLUX: -t=54000
#FLUX: --urgency=16

module load python/2.7.13
source $py2env/bin/activate
cpseriesfile="anyRNA_normed_AllRed.CPseries.gz"
cpfittedfile="anyRNA_normed_AllRed.CPfitted.gz"
cpannotfile="/scratch/groups/herschla/roy-test/Exp1_30mM_Mg_Lib4_20210218/seqData/JGFNV_anyRNA_sorted.CPannot.gz"
concentrationsfile="concentrations_corrected.txt"
cpvariantfile="anyRNA_normed_AllRed.CPvariant.gz"
python $rnamap_scripts/array_fitting_tools/bin/findFmaxDist.py -b $cpseriesfile -f $cpfittedfile -a $cpannotfile -x $concentrationsfile -out $cpvariantfile -k 250 -p 0.05
