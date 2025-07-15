#!/bin/bash
#FLUX: --job-name=multi_species_sim
#FLUX: --queue=blanca-bortz
#FLUX: -t=21600
#FLUX: --priority=16

ml purge
module load matlab/R2019b
save_dr=/projects/dame8201/datasets/woundhealing/multi-species-02-03-22-000-110/
script=/projects/dame8201/datasets/woundhealing/multi-species-02-03-22-000-110/sim2ndorderSDE_multispecies.m
matlab -nodesktop -nodisplay -r "nu_cell = {0,0,0}; include_spec=[1 1 0]; v_opt = 1; run('${script}'); script_txt=fileread('${script}'); save(['${save_dr}','sim',date,'_000_110_','toc',strrep(num2str(toc),'.',''),'.mat']);"
