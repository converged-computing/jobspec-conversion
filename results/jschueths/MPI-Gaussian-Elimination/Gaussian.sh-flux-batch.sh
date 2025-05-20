#!/bin/bash

# Flux directives
#FLUX: --job-name=GAUSSIAN-800-16
#FLUX: --time=15m
#FLUX: --nodes=16
#FLUX: --ntasks=16
#FLUX: --output=GAUSSIAN-800-16.out
#FLUX: --queue=nic-cluster.srv.mst.edu

# Note: The combination of --nodes=16 and --ntasks=16 implies 1 task per node.
# The --output directive in Flux typically captures both stdout and stderr
# if --error is not specified, similar to PBS -j oe.

# Prerun script (retained from original)
/share/apps/job_data_prerun.py

# Execute the application using flux run
# flux run will use the allocated 16 tasks across 16 nodes.
flux run -n 16 /nethome/users/jpm2t4/gaussian/gaussian /nethome/users/jpm2t4/gaussian/matrix.800.txt