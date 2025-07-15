#!/bin/bash
#FLUX: --job-name=calcFST
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --priority=16

set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge  # Reset the modules to the system default
module load angsd/0.931-GCC-8.2.0-2.31.1
realSFS data_31_01_20/Can_40_freq.saf.idx data_31_01_20/Can_14_freq.saf.idx -P 16 >analysis/Can_40.Can_14.ml
realSFS data_31_01_20/Lof_07_freq.saf.idx data_31_01_20/Lof_11_freq.saf.idx -P 16 >analysis/Lof_07.Lof_11.ml
realSFS data_31_01_20/Lof_07_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -P 16 >analysis/Lof_07.Lof_14.ml
realSFS data_31_01_20/Lof_11_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -P 16 >analysis/Lof_11.Lof_14.ml
realSFS data_31_01_20/Can_40_freq.saf.idx data_31_01_20/Lof_07_freq.saf.idx -P 16 >analysis/Can_40.Lof_07.ml
realSFS data_31_01_20/Can_14_freq.saf.idx data_31_01_20/Lof_11_freq.saf.idx -P 16 >analysis/Can_14.Lof_11.ml
realSFS data_31_01_20/Can_14_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -P 16 >analysis/Can_14.Lof_14.ml
realSFS fst index data_31_01_20/Can_40_freq.saf.idx data_31_01_20/Can_14_freq.saf.idx -sfs analysis/Can_40.Can_14.ml -fstout analysis/Can_40.Can_14
realSFS fst index data_31_01_20/Lof_07_freq.saf.idx data_31_01_20/Lof_11_freq.saf.idx -sfs analysis/Lof_07.Lof_11.ml -fstout analysis/Lof_07.Lof_11
realSFS fst index data_31_01_20/Lof_07_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -sfs analysis/Lof_07.Lof_14.ml -fstout analysis/Lof_07.Lof_14
realSFS fst index data_31_01_20/Lof_11_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -sfs analysis/Lof_11.Lof_14.ml -fstout analysis/Lof_11.Lof_14
realSFS fst index data_31_01_20/Can_40_freq.saf.idx data_31_01_20/Lof_07_freq.saf.idx -sfs analysis/Can_40.Lof_07.ml -fstout analysis/Can_40.Lof_07
realSFS fst index data_31_01_20/Can_14_freq.saf.idx data_31_01_20/Lof_11_freq.saf.idx -sfs analysis/Can_14.Lof_11.ml -fstout analysis/Can_14.Lof_11
realSFS fst index data_31_01_20/Can_14_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -sfs analysis/Can_14.Lof_14.ml -fstout analysis/Can_14.Lof_14
realSFS fst stats analysis/Can_40.Can_14.fst.idx 
realSFS fst stats analysis/Lof_07.Lof_11.fst.idx 
realSFS fst stats analysis/Lof_07.Lof_14.fst.idx 
realSFS fst stats analysis/Lof_11.Lof_14.fst.idx 
realSFS fst stats analysis/Can_40.Lof_07.fst.idx 
realSFS fst stats analysis/Can_14.Lof_11.fst.idx 
realSFS fst stats analysis/Can_14.Lof_14.fst.idx 
realSFS fst stats2 analysis/Can_40.Can_14.fst.idx -win 50000 -step 10000 -type 2 >analysis/Can_40.Can_14.slide
realSFS fst stats2 analysis/Lof_07.Lof_11.fst.idx -win 50000 -step 10000 -type 2 >analysis/Lof_07.Lof_11.slide
realSFS fst stats2 analysis/Lof_07.Lof_14.fst.idx -win 50000 -step 10000 -type 2 >analysis/Lof_07.Lof_14.slide
realSFS fst stats2 analysis/Lof_11.Lof_14.fst.idx -win 50000 -step 10000 -type 2 >analysis/Lof_11.Lof_14.slide
realSFS fst stats2 analysis/Can_40.Lof_07.fst.idx -win 50000 -step 10000 -type 2 >analysis/Can_40.Lof_07.slide
realSFS fst stats2 analysis/Can_14.Lof_11.fst.idx -win 50000 -step 10000 -type 2 >analysis/Can_14.Lof_11.slide
realSFS fst stats2 analysis/Can_14.Lof_14.fst.idx -win 50000 -step 10000 -type 2 >analysis/Can_14.Lof_14.slide
realSFS fst print analysis/Can_40.Can_14.fst.idx | gzip > analysis/Can_40.Can_14.fst.AB.gz
realSFS fst print analysis/Lof_07.Lof_11.fst.idx | gzip > analysis/Lof_07.Lof_11.fst.AB.gz
realSFS fst print analysis/Lof_07.Lof_14.fst.idx | gzip > analysis/Lof_07.Lof_14.fst.AB.gz
realSFS fst print analysis/Lof_11.Lof_14.fst.idx | gzip > analysis/Lof_11.Lof_14.fst.AB.gz
cat data_2020.05.07/GATK_filtered_SNP_no_dam2.tab > tmp/gatk.tab # trim off the header from the list of good sites so that ANGSD can index it
angsd sites index tmp/gatk.tab
realSFS data_31_01_20/Can_40_freq.saf.idx data_31_01_20/Can_14_freq.saf.idx -P 16 -sites tmp/gatk.tab  >analysis/Can_40.Can_14.gatk.ml
realSFS data_31_01_20/Lof_07_freq.saf.idx data_31_01_20/Lof_11_freq.saf.idx -P 16 -sites tmp/gatk.tab >analysis/Lof_07.Lof_11.gatk.ml
realSFS data_31_01_20/Lof_07_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -P 16 -sites tmp/gatk.tab >analysis/Lof_07.Lof_14.gatk.ml
realSFS data_31_01_20/Lof_11_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -P 16 -sites tmp/gatk.tab >analysis/Lof_11.Lof_14.gatk.ml
realSFS data_31_01_20/Can_40_freq.saf.idx data_31_01_20/Lof_07_freq.saf.idx -P 16 -sites tmp/gatk.tab >analysis/Can_40.Lof_07.gatk.ml
realSFS data_31_01_20/Can_14_freq.saf.idx data_31_01_20/Lof_11_freq.saf.idx -P 16 -sites tmp/gatk.tab >analysis/Can_14.Lof_11.gatk.ml
realSFS data_31_01_20/Can_14_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -P 16 -sites tmp/gatk.tab >analysis/Can_14.Lof_14.gatk.ml
realSFS fst index data_31_01_20/Can_40_freq.saf.idx data_31_01_20/Can_14_freq.saf.idx -sfs analysis/Can_40.Can_14.gatk.ml -fstout analysis/Can_40.Can_14.gatk -sites tmp/gatk.tab
realSFS fst index data_31_01_20/Lof_07_freq.saf.idx data_31_01_20/Lof_11_freq.saf.idx -sfs analysis/Lof_07.Lof_11.gatk.ml -fstout analysis/Lof_07.Lof_11.gatk -sites tmp/gatk.tab
realSFS fst index data_31_01_20/Lof_07_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -sfs analysis/Lof_07.Lof_14.gatk.ml -fstout analysis/Lof_07.Lof_14.gatk -sites tmp/gatk.tab
realSFS fst index data_31_01_20/Lof_11_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -sfs analysis/Lof_11.Lof_14.gatk.ml -fstout analysis/Lof_11.Lof_14.gatk -sites tmp/gatk.tab
realSFS fst index data_31_01_20/Can_40_freq.saf.idx data_31_01_20/Lof_07_freq.saf.idx -sfs analysis/Can_40.Lof_07.gatk.ml -fstout analysis/Can_40.Lof_07.gatk -sites tmp/gatk.tab
realSFS fst index data_31_01_20/Can_14_freq.saf.idx data_31_01_20/Lof_11_freq.saf.idx -sfs analysis/Can_14.Lof_11.gatk.ml -fstout analysis/Can_14.Lof_11.gatk -sites tmp/gatk.tab
realSFS fst index data_31_01_20/Can_14_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -sfs analysis/Can_14.Lof_14.gatk.ml -fstout analysis/Can_14.Lof_14.gatk -sites tmp/gatk.tab
realSFS fst stats analysis/Can_40.Can_14.gatk.fst.idx 
realSFS fst stats analysis/Lof_07.Lof_11.gatk.fst.idx 
realSFS fst stats analysis/Lof_07.Lof_14.gatk.fst.idx 
realSFS fst stats analysis/Lof_11.Lof_14.gatk.fst.idx 
realSFS fst stats analysis/Can_40.Lof_07.gatk.fst.idx 
realSFS fst stats analysis/Can_14.Lof_11.gatk.fst.idx 
realSFS fst stats analysis/Can_14.Lof_14.gatk.fst.idx 
realSFS fst stats2 analysis/Can_40.Can_14.gatk.fst.idx -win 50000 -step 10000 -type 2 >analysis/Can_40.Can_14.gatk.slide
realSFS fst stats2 analysis/Lof_07.Lof_11.gatk.fst.idx -win 50000 -step 10000 -type 2 >analysis/Lof_07.Lof_11.gatk.slide
realSFS fst stats2 analysis/Lof_07.Lof_14.gatk.fst.idx -win 50000 -step 10000 -type 2 >analysis/Lof_07.Lof_14.gatk.slide
realSFS fst stats2 analysis/Lof_11.Lof_14.gatk.fst.idx -win 50000 -step 10000 -type 2 >analysis/Lof_11.Lof_14.gatk.slide
realSFS fst stats2 analysis/Can_40.Lof_07.gatk.fst.idx -win 50000 -step 10000 -type 2 >analysis/Can_40.Lof_07.gatk.slide
realSFS fst stats2 analysis/Can_14.Lof_11.gatk.fst.idx -win 50000 -step 10000 -type 2 >analysis/Can_14.Lof_11.gatk.slide
realSFS fst stats2 analysis/Can_14.Lof_14.gatk.fst.idx -win 50000 -step 10000 -type 2 >analysis/Can_14.Lof_14.gatk.slide
zcat analysis/ld.unlinked.Can.gatk.nodam.csv.gz | tail -n +2 | sed 's/\,/\t/g' | cut -f 1-2 > tmp/ld.unlinked.Can.gatk.nodam.tab
zcat analysis/ld.unlinked.Lof.gatk.nodam.csv.gz | tail -n +2 | sed 's/\,/\t/g' | cut -f 1-2 > tmp/ld.unlinked.Lof.gatk.nodam.tab
zcat analysis/ld.unlinked.gatk.nodam.csv.gz | tail -n +2 | sed 's/\,/\t/g' | cut -f 1-2 > tmp/ld.unlinked.gatk.nodam.tab
angsd sites index tmp/ld.unlinked.Can.gatk.nodam.tab
angsd sites index tmp/ld.unlinked.Lof.gatk.nodam.tab
angsd sites index tmp/ld.unlinked.gatk.nodam.tab
realSFS data_31_01_20/Can_40_freq.saf.idx data_31_01_20/Can_14_freq.saf.idx -P 16 -sites tmp/ld.unlinked.Can.gatk.nodam.tab  >analysis/Can_40.Can_14.gatk.unlinked.ml
realSFS data_31_01_20/Lof_07_freq.saf.idx data_31_01_20/Lof_11_freq.saf.idx -P 16 -sites tmp/ld.unlinked.Lof.gatk.nodam.tab >analysis/Lof_07.Lof_11.gatk.unlinked.ml
realSFS data_31_01_20/Lof_07_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -P 16 -sites tmp/ld.unlinked.Lof.gatk.nodam.tab >analysis/Lof_07.Lof_14.gatk.unlinked.ml
realSFS data_31_01_20/Lof_11_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -P 16 -sites tmp/ld.unlinked.Lof.gatk.nodam.tab >analysis/Lof_11.Lof_14.gatk.unlinked.ml
realSFS data_31_01_20/Can_40_freq.saf.idx data_31_01_20/Lof_07_freq.saf.idx -P 16 -sites tmp/ld.unlinked.gatk.nodam.tab >analysis/Can_40.Lof_07.gatk.unlinked.ml
realSFS data_31_01_20/Can_14_freq.saf.idx data_31_01_20/Lof_11_freq.saf.idx -P 16 -sites tmp/ld.unlinked.gatk.nodam.tab >analysis/Can_14.Lof_11.gatk.unlinked.ml
realSFS data_31_01_20/Can_14_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -P 16 -sites tmp/ld.unlinked.gatk.nodam.tab >analysis/Can_14.Lof_14.gatk.unlinked.ml
realSFS fst index data_31_01_20/Can_40_freq.saf.idx data_31_01_20/Can_14_freq.saf.idx -sfs analysis/Can_40.Can_14.gatk.unlinked.ml -fstout analysis/Can_40.Can_14.gatk.unlinked -sites tmp/ld.unlinked.Can.gatk.nodam.tab
realSFS fst index data_31_01_20/Lof_07_freq.saf.idx data_31_01_20/Lof_11_freq.saf.idx -sfs analysis/Lof_07.Lof_11.gatk.unlinked.ml -fstout analysis/Lof_07.Lof_11.gatk.unlinked -sites tmp/ld.unlinked.Lof.gatk.nodam.tab
realSFS fst index data_31_01_20/Lof_07_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -sfs analysis/Lof_07.Lof_14.gatk.unlinked.ml -fstout analysis/Lof_07.Lof_14.gatk.unlinked -sites tmp/ld.unlinked.Lof.gatk.nodam.tab
realSFS fst index data_31_01_20/Lof_11_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -sfs analysis/Lof_11.Lof_14.gatk.unlinked.ml -fstout analysis/Lof_11.Lof_14.gatk.unlinked -sites tmp/ld.unlinked.Lof.gatk.nodam.tab
realSFS fst index data_31_01_20/Can_40_freq.saf.idx data_31_01_20/Lof_07_freq.saf.idx -sfs analysis/Can_40.Lof_07.gatk.unlinked.ml -fstout analysis/Can_40.Lof_07.gatk.unlinked -sites tmp/ld.unlinked.gatk.unlinked.tab
realSFS fst index data_31_01_20/Can_14_freq.saf.idx data_31_01_20/Lof_11_freq.saf.idx -sfs analysis/Can_14.Lof_11.gatk.unlinked.ml -fstout analysis/Can_14.Lof_11.gatk.unlinked -sites tmp/ld.unlinked.gatk.unlinked.tab
realSFS fst index data_31_01_20/Can_14_freq.saf.idx data_31_01_20/Lof_14_freq.saf.idx -sfs analysis/Can_14.Lof_14.gatk.unlinked.ml -fstout analysis/Can_14.Lof_14.gatk.unlinked -sites tmp/ld.unlinked.gatk.unlinked.tab
realSFS fst stats analysis/Can_40.Can_14.gatk.unlinked.fst.idx 
realSFS fst stats analysis/Lof_07.Lof_11.gatk.unlinked.fst.idx 
realSFS fst stats analysis/Lof_07.Lof_14.gatk.unlinked.fst.idx 
realSFS fst stats analysis/Lof_11.Lof_14.gatk.unlinked.fst.idx 
realSFS fst stats analysis/Can_40.Lof_07.gatk.unlinked.fst.idx 
realSFS fst stats analysis/Can_14.Lof_11.gatk.unlinked.fst.idx 
realSFS fst stats analysis/Can_14.Lof_14.gatk.unlinked.fst.idx 
realSFS fst stats2 analysis/Can_40.Can_14.gatk.unlinked.fst.idx -win 50000 -step 10000 -type 2 >analysis/Can_40.Can_14.gatk.unlinked.slide
realSFS fst stats2 analysis/Lof_07.Lof_11.gatk.unlinked.fst.idx -win 50000 -step 10000 -type 2 >analysis/Lof_07.Lof_11.gatk.unlinked.slide
realSFS fst stats2 analysis/Lof_07.Lof_14.gatk.unlinked.fst.idx -win 50000 -step 10000 -type 2 >analysis/Lof_07.Lof_14.gatk.unlinked.slide
realSFS fst stats2 analysis/Lof_11.Lof_14.gatk.unlinked.fst.idx -win 50000 -step 10000 -type 2 >analysis/Lof_11.Lof_14.gatk.unlinked.slide
realSFS fst stats2 analysis/Can_40.Lof_07.gatk.unlinked.fst.idx -win 50000 -step 10000 -type 2 >analysis/Can_40.Lof_07.gatk.unlinked.slide
realSFS fst stats2 analysis/Can_14.Lof_11.gatk.unlinked.fst.idx -win 50000 -step 10000 -type 2 >analysis/Can_14.Lof_11.gatk.unlinked.slide
realSFS fst stats2 analysis/Can_14.Lof_14.gatk.unlinked.fst.idx -win 50000 -step 10000 -type 2 >analysis/Can_14.Lof_14.gatk.unlinked.slide
rm tmp/gatk.*
rm tmp/ld.unlinked.*
