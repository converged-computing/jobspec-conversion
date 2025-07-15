#!/bin/bash
#FLUX: --job-name=TRSV
#FLUX: -c=40
#FLUX: --urgency=16

export OMP_NUM_THREADS='$THRDS'
export MKL_NUM_THREADS='$THRDS'

LOGS=./logs/
SCRIPTPATH=./
BINLIB=../build/demo/spmm_demo
MAT_DIR=/home/m/mmehride/kazem/UFDB/
mkdir $LOGS
THRDS=20
export OMP_NUM_THREADS=$THRDS
export MKL_NUM_THREADS=$THRDS
header=1
clt_min_widths=( 4 )
clt_max_distances=( 4 )
M_TILE_SIZES=( 4 8 16 32 )
N_TILE_SIZES=( 4 )
B_MAT_COL=( 32 128 256 512 )
  while read line; do
    for md in "${clt_max_distances[@]}"; do
      for mw in "${clt_min_widths[@]}"; do
        for mtile in "${M_TILE_SIZES[@]}"; do
          for ntile in "${N_TILE_SIZES[@]}"; do
            for bcol in "${B_MAT_COL[@]}"; do
              if [ "$ntile" -gt "$bcol" ]; then
                continue
              fi
              if [ $header -eq 1 ]; then
                $BINLIB -m $MAT_DIR/$line -n SPMM -s CSR -t $THRDS --m_tile_size=$mtile --n_tile_size=$ntile --b_matrix_columns=$bcol -d --clt_width=$mw --col_th=$md > $LOGS/spmm_dlmc.csv
                header=0
              else
                $BINLIB -m $MAT_DIR/$line -n SPMM -s CSR -t $THRDS --b_matrix_columns=$bcol --m_tile_size=$mtile --n_tile_size=$ntile --clt_width=$mw --col_th=$md >> $LOGS/spmm_dlmc.csv
              fi
            done
          done
        done
      done
    done
  done
