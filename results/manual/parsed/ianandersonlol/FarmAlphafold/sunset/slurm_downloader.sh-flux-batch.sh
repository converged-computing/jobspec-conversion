#!/bin/bash
#FLUX: --job-name=adorable-spoon-9872
#FLUX: --queue=bmh
#FLUX: --urgency=16

module load spack/aria2
bash /home/icanders/alphafold/scripts/download_all_data.sh /home/icanders/alphafoldDownload/
