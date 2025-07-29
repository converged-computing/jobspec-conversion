#!/bin/bash
#SBATCH --job-name=yrv_analysis
#SBATCH --output=yrv_analysis%j.log
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100gb
#SBATCH --partition=compute
#SBATCH: --exclusive
#SBATCH --chdir=/vortexfs1/scratch/yaamini.venkataraman/05-analysis

echo "Prepare for analysis"
echo "Create chromosome length file"
echo "Done creating chromosome file"
echo "Revise bedGraphs"
echo "Done revising bedGraphs"
echo "Done preparing for analysis"
echo "Summarize Module"
module load singularity/3.7
chmod +x /vortexfs1/home/yaamini.venkataraman/05-BAT-summarize.sh
chmod +x /vortexfs1/home/yaamini.venkataraman/05-BAT-overview.sh
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/05-analysis-envfile.txt \
--bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch,/vortexfs1/home/yaamini.venkataraman/:/yaaminiv \
/vortexfs1/home/naluru/bat_latest.sif \
/yaaminiv/05-BAT-summarize.sh
echo "Done with summarize"
echo "Overview Module"
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/05-analysis-envfile.txt \
--bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch,/vortexfs1/home/yaamini.venkataraman/:/yaaminiv \
/vortexfs1/home/naluru/bat_latest.sif \
/yaaminiv/05-BAT-overview.sh
echo "Done with overview"
