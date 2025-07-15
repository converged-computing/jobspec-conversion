#!/bin/bash
#FLUX: --job-name=gloopy-blackbean-2200
#FLUX: --priority=16

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load matlab/2017a
matlab -nodisplay -r "spkParse96well; quit"
