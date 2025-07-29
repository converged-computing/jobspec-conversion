#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/kntkb/3D-MIL-QSAR-test/experiment/gpcrdb/classA_lipid_cnr1_affinity_ic50/lsf-submit.sh
