#!/bin/bash
# Flux directives
#flux: -N 1
#flux: -n 1
#flux: -g 1
#flux: -t 1:00:00
#flux: -o laghos.log%j
#flux: -J laghos

# Note on LSF -P CSC322 (Project/Account):
# In Flux, account/project information is typically handled at submission time
# (e.g., flux submit --setattr system.job.account=CSC322 my_script.sh)
# or through queue configurations, rather than an in-script directive.

date
# Copy application and data to working directory
# $MEMBERWORK is an environment variable typically available on OLCF systems
cp ./Laghos/raja/laghos $MEMBERWORK/csc322
cp ./Laghos/data/square01_quad.mesh $MEMBERWORK/csc322

# Change to the working directory
cd $MEMBERWORK/csc322

# Execute the application using hpcrun for profiling
# The job is allocated 1 node, 1 task, and 1 GPU by the #flux directives.
# flux run will launch the command as this single task, which will have access to the allocated GPU.
flux run hpcrun -e nvidia-cuda ./laghos -p 0 -m ./square01_quad.mesh -rs 3 -tf 0.75 -pa -cuda