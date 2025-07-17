#!/bin/bash
#FLUX: --job-name=evasive-chair-0903
#FLUX: --queue=batch
#FLUX: -t=86400
#FLUX: --urgency=16

command="ssh -L 5000:dh-mgmt2.hpc.msoe.edu:5000 andreanoc@dh0-mgmt2.hpc.msoe.edu  &&
python ./app.py"
srun $command
