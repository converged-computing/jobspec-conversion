#!/bin/bash
#FLUX: --job-name=eccentric-omelette-6793
#FLUX: --urgency=16

module load gcc/7.1.0 openmpi/3.1.4 R/3.5.3
Rscript TNFileJoining_Hill05.R "/scratch/js4yd/MorrisSA/TNprocessing/" 'DateColumnNames.txt' 'SAResults_HillStreamflow_p6_t.txt' '/scratch/js4yd/MorrisSA/TNprocessing/TNdata/' "TNSAreps_Hill05_All.RData" 'SAResults_HillTN05_p3_All.txt'
