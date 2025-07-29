#!/bin/bash
#SBATCH --job-name=cellranger
#SBATCH --account=pi-gilad
#SBATCH --output=cellranger.batch1.hc_06.out
#SBATCH --error=cellranger.batch1.hc_06.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=128G
#SBATCH --time=1-12:00:00
#SBATCH --partition=caslake

/project2/gilad/ghousman/cellranger/cellranger-7.0.0/bin/cellranger multi --id human_chimp_chondro_time_batch1_hc_06 \
                                                    								      --csv ./../chondro-time-evo/code/cellranger_06/cellranger.batch1.hc.csv \
                                                    								      --localcores 12 \
                                                    								      --localmem 48
