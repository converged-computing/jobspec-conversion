#!/bin/bash
#SBATCH --job-name=VP_MarilynMonroe_Baseline
#SBATCH --account=fc_xenopus
#SBATCH --mail-user=lilianzhang@berkeley.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-12:00:00
#SBATCH --partition=savio_bigmem

module load gcc openmpi
module load python
module load gnu-parallel/2019.03.22
JELLYPATH=/global/scratch/users/lilianzhang/RNASeq2/20210702/MarilynMonroe/Baseline/
POSTINIT_DF_PATH=/global/scratch/users/lilianzhang/RNASeq2/20210702/MarilynMonroe/SD/MarilynMonroeSD_PostInitializationDF.csv
PARENTDIR=/tmp/vp_data
parallel singularity exec --no-mount tmp --overlay overlay{}.img image_latest.sif /bin/bash vp_exec_script.sh ::: {1..24}
