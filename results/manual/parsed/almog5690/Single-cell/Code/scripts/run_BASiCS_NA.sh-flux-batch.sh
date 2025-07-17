#!/bin/bash
#FLUX: --job-name=dinosaur-cattywampus-8857
#FLUX: -n=4
#FLUX: -t=604800
#FLUX: --urgency=16

<<<<<<< Updated upstream
module load R4
=======
>>>>>>> Stashed changes
module load R4
<<<<<<< Updated upstream
=======
module load R4
>>>>>>> Stashed changes
Rscript --vanilla ../run_BASiCS_commandline.R Blood_SC Blood NA
