#!/bin/bash
#FLUX: --job-name=SCMcG_Assignment_1
#FLUX: -n=80
#FLUX: --queue=teaching
#FLUX: -t=1200
#FLUX: --urgency=16

  module purge
  module load nvidia/sdk/21.3
  module load ansys/21.2
  module load anaconda/python-3.9.7/2021.11
/opt/software/scripts/job_prologue.sh  
python SCMcG_Assignment_1.py
/opt/software/scripts/job_epilogue.sh 
