#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/glamod/glamod-land-ingest/land_ingest/psv_processor/OLD.submit-jobs-as-job-array.sh
