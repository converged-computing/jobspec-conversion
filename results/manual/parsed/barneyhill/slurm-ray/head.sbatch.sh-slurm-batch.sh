#!/bin/bash
#FLUX: --job-name=head
#FLUX: --queue=short
#FLUX: --urgency=16

source /users/lindgren/hjo721/job-scripts/conda.sh aminosgym
echo "this machine has $(nproc) cpus"
ray start --head --include-dashboard true --dashboard-host 0.0.0.0 --dashboard-port 5712 --node-ip-address=$(hostname)
python process_transcripts.py
