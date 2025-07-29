#!/bin/bash
#SBATCH --job-name=yrv_DMR
#SBATCH --output=yrv_DMR%j.log
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100gb
#SBATCH --exclusive
#SBATCH --chdir=/vortexfs1/scratch/yaamini.venkataraman/06-DMR

module load singularity/3.7
chmod +x /vortexfs1/home/yaamini.venkataraman/06-BAT-DMRcalling.sh
echo "DMR Calling Module"
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/06-DMR-envfile.txt \
--bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch,/vortexfs1/home/yaamini.venkataraman/:/yaaminiv \
/vortexfs1/home/naluru/bat_latest.sif \
/yaaminiv/06-BAT-DMRcalling.sh
echo "Done with DMR calling"
