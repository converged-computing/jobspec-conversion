#!/bin/bash
#SBATCH --job-name=FFmax
#SBATCH --output=logging/FindFmax-%j.out
#SBATCH --error=logging/FindFmax-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=15:00:00
#SBATCH --partition=biochem,owners,normal
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

module load python/2.7.13
source /home/groups/herschla/rna_map/scripts/new_scripts/venv_2_7_13/bin/activate
cpseriesfile="anyRNA_normed_AllRed.CPseries.gz"
cpfittedfile="anyRNA_normed_AllRed.CPfitted.gz"
cpannotfile="/scratch/groups/herschla/roy-test/Exp1_30mM_Mg_Lib4_20210218/seqData/JGFNV_anyRNA_sorted.CPannot.gz"
concentrationsfile="concentrations_corrected.txt"
cpvariantfile="anyRNA_normed_AllRed.CPvariant.gz"
python /home/groups/herschla/rna_map/scripts/array_fitting_tools/bin/findFmaxDist.py -b $cpseriesfile -f $cpfittedfile -a $cpannotfile -x $concentrationsfile -out $cpvariantfile -k 250 -p 0.05
