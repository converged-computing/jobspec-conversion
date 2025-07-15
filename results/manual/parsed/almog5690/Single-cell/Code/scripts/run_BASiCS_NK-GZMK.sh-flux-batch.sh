#!/bin/bash
#FLUX: --job-name=goodbye-platanos-8871
#FLUX: -n=4
#FLUX: -t=604800
#FLUX: --priority=16

<<<<<<< Updated upstream
module load R4
=======
>>>>>>> Stashed changes
module load R4
<<<<<<< Updated upstream
=======
module load R4
>>>>>>> Stashed changes
Rscript --vanilla ../run_BASiCS_commandline.R Blood_SC Blood NK-GZMK
