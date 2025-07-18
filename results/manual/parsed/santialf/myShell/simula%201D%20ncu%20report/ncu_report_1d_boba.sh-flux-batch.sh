#!/bin/bash
#FLUX: --job-name=muffled-leopard-5128
#FLUX: --queue=a100q
#FLUX: -t=900
#FLUX: --urgency=16

export PATH='$PATH:/usr/local/cuda/bin'

export PATH=$PATH:/usr/local/cuda/bin
nvidia-smi
nvcc --version
make 
MATRIX_DIR="/global/D1/homes/santiago/reorderings/boba/"
INPUT_MATRICES=("AMD/G3_circuit.mtx.gz"
"Bodendiek/CurlCurl_4.mtx.gz"
"DIMACS10/333SP.mtx.gz"
"DIMACS10/adaptive.mtx.gz"
"DIMACS10/AS365.mtx.gz"
"DIMACS10/delaunay_n24.mtx.gz"
"DIMACS10/europe_osm.mtx.gz"
"DIMACS10/hugebubbles-00020.mtx.gz"
"DIMACS10/hugetrace-00020.mtx.gz"
"DIMACS10/hugetric-00020.mtx.gz"
"DIMACS10/kron_g500-logn21.mtx.gz"
"DIMACS10/M6.mtx.gz"
"DIMACS10/NLR.mtx.gz"
"DIMACS10/rgg_n_2_24_s0.mtx.gz"
"DIMACS10/road_usa.mtx.gz"
"DIMACS10/venturiLevel3.mtx.gz"
"Fluorem/HV15R.mtx.gz"
"Freescale/circuit5M.mtx.gz"
"GAP/GAP-road.mtx.gz"
"GenBank/kmer_V1r.mtx.gz"
"Gleich/wb-edu.mtx.gz"
"Janna/Queen_4147.mtx.gz"
"LAW/uk-2005.mtx.gz"
"MAWI/mawi_201512020330.mtx.gz"
"Mycielski/mycielskian19.mtx.gz"
"Pajek/patents.mtx.gz"
"Rajat/rajat31.mtx.gz"
"Schenk_AFE/af_shell10.mtx.gz"
"Schenk/nlpkkt240.mtx.gz"
"SNAP/soc-LiveJournal1.mtx.gz"
"SNAP/com-LiveJournal.mtx.gz"
"SNAP/cit-Patents.mtx.gz"
"SNAP/sx-stackoverflow.mtx.gz"
"SNAP/wiki-Talk.mtx.gz"
"SNAP/roadNet-CA.mtx.gz"
"SNAP/wiki-topcats.mtx.gz"
"SNAP/as-Skitter.mtx.gz"
"vanHeukelum/cage15.mtx.gz"
"VLSI/stokes.mtx.gz"
"Zaoui/kkt_power.mtx.gz"
)    
mkdir -p /work/$USER/tmp8
for input_matrix in "${INPUT_MATRICES[@]}"; do
    # Extract the base file name (without path or extension)
    base_filename=$(basename "$input_matrix" .gz)
    # Concatenate path with matrix name
    path_to_input_matrix="$MATRIX_DIR$input_matrix"
    # Decompress the input matrix
    gunzip -c "$path_to_input_matrix" > "/work/santiago/tmp8/$base_filename"
    # Create directory if it doesn't exist
    mkdir -p "reports"
    # Run the program with the input matrix
    srun ncu -o "reports/report_1D_boba_$base_filename" -k spmv_1D -c 1 --set full ./rows_per_thread "/work/santiago/tmp8/$base_filename"
    # Clean up the temporary decompressed file
    rm "/work/santiago/tmp8/$base_filename"
done
