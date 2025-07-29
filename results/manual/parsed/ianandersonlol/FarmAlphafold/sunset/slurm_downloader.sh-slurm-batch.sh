#!/bin/bash
#FLUX: --job-name=alphafoldDownloadMove
#FLUX: --queue=bmh
#FLUX: -t=540000
#FLUX: --urgency=16

module load spack/aria2
bash /home/icanders/alphafold/scripts/download_all_data.sh /home/icanders/alphafoldDownload/
