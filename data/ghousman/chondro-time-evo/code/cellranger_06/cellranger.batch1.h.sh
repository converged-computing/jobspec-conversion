#!/bin/bash

# sbatch submission script to run main snakemake process
# submits individual jobs from the compute node

#SBATCH --job-name=cellranger
#SBATCH --output=cellranger.batch1.h_06.out
#SBATCH --error=cellranger.batch1.h_06.err
#SBATCH --account=pi-gilad
#SBATCH --time=36:00:00
#SBATCH --partition=caslake
#SBATCH --mem=48G
#SBATCH --tasks-per-node=12

/project2/gilad/ghousman/cellranger/cellranger-7.0.0/bin/cellranger multi --id human_chimp_chondro_time_batch1_h_06 \
                                                    								      --csv ./../chondro-time-evo/code/cellranger_06/cellranger.batch1.h.csv \
                                                    								      --localcores 12 \
                                                    								      --localmem 48
