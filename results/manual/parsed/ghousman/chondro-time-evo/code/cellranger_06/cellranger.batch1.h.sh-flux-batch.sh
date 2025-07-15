#!/bin/bash
#FLUX: --job-name=cellranger
#FLUX: --queue=caslake
#FLUX: -t=129600
#FLUX: --urgency=16

/project2/gilad/ghousman/cellranger/cellranger-7.0.0/bin/cellranger multi --id human_chimp_chondro_time_batch1_h_06 \
                                                    								      --csv ./../chondro-time-evo/code/cellranger_06/cellranger.batch1.h.csv \
                                                    								      --localcores 12 \
                                                    								      --localmem 48
