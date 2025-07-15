#!/bin/bash
#FLUX: --job-name=cellranger
#FLUX: --queue=caslake
#FLUX: -t=129600
#FLUX: --urgency=16

/project2/gilad/ghousman/cellranger/cellranger-7.0.0/bin/cellranger multi --id human_chimp_chondro_time_batch2_hc \
                                                                          --csv ./../chondro-time-evo/code/cellranger/cellranger.batch2.hc.csv \
                                                                          --localcores 12 \
                                                                          --localmem 48
