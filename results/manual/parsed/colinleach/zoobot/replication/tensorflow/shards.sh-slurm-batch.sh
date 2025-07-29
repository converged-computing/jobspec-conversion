#!/bin/bash
#FLUX: --job-name=shards
#FLUX: --exclusive
#FLUX: -t=82800
#FLUX: --urgency=16

pwd; hostname; date
CATALOG_DIR=/share/nas2/walml/galaxy_zoo/decals/long_term_model_archive/prepared_catalogs/decals_dr_galahad
SHARD_DIR=/share/nas2/walml/repos/gz-decals-classifiers/data/decals/shards/all_2p5_unfiltered_n2
ZOOBOT_DIR=/share/nas2/walml/repos/zoobot
PYTHON=/share/nas2/walml/miniconda3/envs/zoobot/bin/python
$PYTHON $ZOOBOT_DIR/create_shards.py \
    --labelled-catalog $CATALOG_DIR/labelled_catalog.csv \
    --unlabelled-catalog $CATALOG_DIR/unlabelled_catalog.csv \
    --eval-size 10000 \
    --shard-dir $SHARD_DIR \
    --img-size 300
