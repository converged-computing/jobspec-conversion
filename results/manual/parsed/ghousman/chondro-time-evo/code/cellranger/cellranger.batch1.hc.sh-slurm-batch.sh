#!/bin/bash
#SBATCH --job-name=cellranger
#SBATCH --account=pi-gilad
#SBATCH --output=cellranger.batch1.hc.out
#SBATCH --error=cellranger.batch1.hc.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=128G
#SBATCH --time=1-12:00:00

/project2/gilad/ghousman/cellranger/cellranger-7.0.0/bin/cellranger multi --id human_chimp_chondro_time_batch1_hc \
                                                    								      --csv ./../chondro-time-evo/code/cellranger/cellranger.batch1.hc.csv \
                                                    								      --localcores 12 \
                                                    								      --localmem 48
