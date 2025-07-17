#!/bin/bash
#FLUX: --job-name=ragtags
#FLUX: --queue=phillips
#FLUX: -t=36000
#FLUX: --urgency=16

module load prl python/2.7.13
module load easybuild  icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132 Stacks/1.46
ecor1="/projects/phillipslab/ateterina/CR_map/FINAL/Barcodes_Well_EcoR1_Stacks_names.txt"
outd="/projects/phillipslab/ateterina/CR_map/FINAL/stacks"
mkdir -p $outd/A1 $outd/A2 $outd/B1 $outd/B2
cd /projects/phillipslab/ateterina/CR_map/FINAL/data
echo "EcoR1";
cd A1;
	echo "A1";
	process_radtags -1 filtered_forward.fastq -2 filtered_reverse.fastq  -b $ecor1 -o $outd/A1 -e ecoRI -c -r -q -t 90 --barcode_dist_2 1 ;
cd ..;
cd A2;
	echo "A2";
	process_radtags -1 filtered_forward.fastq -2 filtered_reverse.fastq  -b $ecor1 -o $outd/A2 -e ecoRI -c -r -q -t 90 --barcode_dist_2 1 ;
cd ..;
cd B1;
	echo "B1";
	process_radtags -1 filtered_forward.fastq -2 filtered_reverse.fastq  -b $ecor1 -o $outd/B1 -e ecoRI -c -r -q -t 90 --barcode_dist_2 1 ;
cd ..;
cd B2;
  echo "B2";
	process_radtags -1 filtered_forward.fastq -2 filtered_reverse.fastq  -b $ecor1 -o $outd/B2 -e ecoRI -c -r -q -t 90 --barcode_dist_2 1 ;
cd ..;
