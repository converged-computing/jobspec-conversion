#!/bin/bash
#FLUX: --job-name=VP_MarilynMonroe_Baseline
#FLUX: --queue=savio_bigmem
#FLUX: -t=129600
#FLUX: --priority=16

module load gcc openmpi
module load python
module load gnu-parallel/2019.03.22
JELLYPATH=/global/scratch/users/lilianzhang/RNASeq2/20210702/MarilynMonroe/Baseline/
POSTINIT_DF_PATH=/global/scratch/users/lilianzhang/RNASeq2/20210702/MarilynMonroe/SD/MarilynMonroeSD_PostInitializationDF.csv
PARENTDIR=/tmp/vp_data
parallel singularity exec --no-mount tmp --overlay overlay{}.img image_latest.sif /bin/bash vp_exec_script.sh ::: {1..24}
