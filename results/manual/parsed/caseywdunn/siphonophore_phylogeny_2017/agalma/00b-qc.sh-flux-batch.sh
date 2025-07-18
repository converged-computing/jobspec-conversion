#!/bin/bash
#FLUX: --job-name=bricky-ricecake-7710
#FLUX: -c=20
#FLUX: -t=129600
#FLUX: --urgency=16

export AGALMA_DB='/gpfs/data/cdunn/analyses/agalma-siphonophora-20170501_reduced.sqlite'
export BIOLITE_RESOURCES='threads=${SLURM_CPUS_ON_NODE},memory=${SLURM_MEM_PER_NODE}M'

sleep $((SLURM_ARRAY_TASK_ID*60))
set -e
export AGALMA_DB="/gpfs/data/cdunn/analyses/agalma-siphonophora-20170501_reduced.sqlite"
export BIOLITE_RESOURCES="threads=${SLURM_CPUS_ON_NODE},memory=${SLURM_MEM_PER_NODE}M"
IDS=(
        HWI-ST625-73-C0JUVACXX-7-AGALMA2
        HWI-ST625-51-C02UNACXX-8-BARGMANNIA
        HWI-ST625-51-C02UNACXX-6-FRILLAGALMA
        HWI-ST625-51-C02UNACXX-7-NANOMIA
        HWI-ST625-73-C0JUVACXX-7-TTAGGC
        HWI-ST625-54-C026EACXX-6-ATCACG
        HWI-ST625-54-C026EACXX-3-TATC
        HWI-ST625-54-C026EACXX-6-TTAGGC
        HWI-ST625-54-C026EACXX-6-ACAGTG
        HWI-ST625-54-C026EACXX-6-GCCAAT
        HWI-ST625-54-C026EACXX-6-CAGATC
        HWI-ST625-54-C026EACXX-7-TAGCTT
        HWI-ST625-54-C026EACXX-7-GGCTAC
        HWI-ST625-54-C026EACXX-8-ATCACG
        HISEQ-129-C25BFACXX-8-HYDRACTINIA
        HWI-ST625-73-C0JUVACXX-7-ATCACG
        HWI-ST625-54-C026EACXX-7-CGATGT
        HWI-ST625-54-C026EACXX-8-TTAGGC
        HWI-ST625-54-C026EACXX-7-TGACCA
        HWI-ST625-54-C026EACXX-8-ACAGTG
        HWI-ST625-54-C026EACXX-7-GATCAG
        HWI-ST625-54-C026EACXX-7-CTTGTA
        HWI-ST625-54-C026EACXX-8-GCCAAT
        HWI-ST625-54-C026EACXX-8-CAGATC
        HWI-ST625-54-C026EACXX-8-ACTTGA
        SRX231866
        HISEQ-168-C3DEYACXX-8-ALATINA
        HWI-ST625-61-C02G3ACxx-6-GGCTAC
        HWI-ST420-69-D0F2NACXX-3-ECTOPLEURA
        HISEQ-134-C27MTACXX-2-PODOCORYNA
        HWI-ST625-159-C4MVCACXX-5-CCGTCC
        HWI-ST625-159-C4MVCACXX-5-AGTTCC
        HWI-ST625-159-C4MVCACXX-5-GTCCGC
        HWI-ST625-159-C4MVCACXX-5-TGACCA
        HWI-ST625-181-C76K5ACXX-2-ATCACG
        HWI-ST625-181-C76K5ACXX-2-ACTTGA
        HWI-ST625-181-C76K5ACXX-2-TAGCTT
        HWI-ST625-181-C76K5ACXX-2-GGCTAC
        HWI-ST625-181-C76K5ACXX-2-CTTGTA
)
ID=${IDS[$SLURM_ARRAY_TASK_ID-1]}
echo $ID
agalma qc --id $ID
