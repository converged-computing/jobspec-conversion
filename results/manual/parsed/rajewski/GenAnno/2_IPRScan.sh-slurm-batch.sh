#!/bin/bash
#SBATCH --output=./history/IPRScan-%A.out
#SBATCH --mail-user=araje002@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=200G

set -euv
module load interproscan
if [ ! -d "$IPROUT" ]; then
  mkdir ~/bigdata/Csativa/results/2_IPRScan
fi
interproscan.sh \
    -i ~/bigdata/Csativa/results/1_FunannotatePredict/predict_results/purple_kush.proteins.fa.$SLURM_ARRAY_TASK_ID \
    -appl CDD,COILS,Gene3D,HAMAP,MobiDBLite,Pfam,PIRSF,PRINTS,ProDom,PROSITEPATTERNS,PROSITEPROFILES,SFLD,SMART,SUPERFAMILY,TIGRFAM \
    -d ~/bigdata/Csativa/results/2_IPRScan \
    --goterms
