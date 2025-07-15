#!/bin/bash
#FLUX: --job-name=sticky-muffin-8915
#FLUX: --queue=bmh
#FLUX: --priority=16

module load spack/aria2
bash /home/icanders/alphafold/scripts/download_all_data.sh /home/icanders/alphafoldDownload/
