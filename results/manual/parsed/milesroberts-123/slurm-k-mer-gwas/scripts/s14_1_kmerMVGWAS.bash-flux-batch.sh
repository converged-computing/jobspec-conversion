#!/bin/bash
#FLUX: --job-name=crunchy-lettuce-9145
#FLUX: --queue=josephsnodes
#FLUX: -t=604800
#FLUX: --urgency=16

echo "This job is running on $HOSTNAME on `date`"
./gemma-0.98.5-linux-static-AMD64 -g allKmersMergedUniqueMAFfiltCat.bimbam.gz -p ./output/pheno_kmerGWAS_FT16_RGR_normalized_imputed.prdt.txt -c kmerCountCovariate.txt -k ./output/kinshipMatrix_FT16_RGR_normalized_kmers.cXX.txt -notsnp -lmm 1 -n 1 2 -o mvKmerGWASresults_FT16_RGR
