#!/bin/bash
#FLUX: --job-name=PyNets
#FLUX: -t=86400
#FLUX: --urgency=16

export SINGULARITY_TMPDIR='$WORKINGDIR'

set -x
set -e
bl2bids
function abspath { echo $(cd $(dirname $1); pwd)/$(basename $1); }
t1w=$(jq -r .t1 config.json)
id=$(jq -r .id config.json)
if [[ $id == "null" ]] || [[ $id == '' ]] || [ -z $id ]; then
    sub=$(jq -r '._inputs[] | select(.id == "anat") | .meta.subject' config.json)
fi
optional=""
rm -rf /tmp/work && mkdir -p /tmp/work && chmod a+rwx /tmp/work
rm -rf output && mkdir -p output && chmod a+rw output
dwi=$(jq -r .dwi config.json)
if [[ ($dwi != "null" || $dwi == '') ]]; then
    bval=$(jq -r .bvals config.json)
    bvec=$(jq -r .bvecs config.json)
    optional="$optional -dwi `abspath $dwi` -bval `abspath $bval` -bvec `abspath $bvec`"
    ses=$(jq -r '._inputs[] | select(.id == "dwi") | .meta.session' config.json)
fi
bold=$(jq -r .bold config.json)
if [[ ($bold != "null" || $bold == '') ]]; then
    conf=$(jq -r .regressors config.json)
    if [[ ($conf != "null" || $conf == '') ]]; then
        optional="$optional -func `abspath $bold` -conf `abspath $conf`"
    else
        optional="$optional -func `abspath $bold`"
    fi
    ses=$(jq -r '._inputs[] | select(.id == "task") | .meta.session' config.json)
fi
if [[ ($bold == "null" || $bold == '') ]] && [[ ($dwi == "null" || $dwi == '') ]];then
    echo "\n\nAt least one of BOLD and DWI are required!"
    exit 1
fi
mask=$(jq -r .mask config.json)
if [[ $mask != "null" ]];then
    optional="$optional -m `abspath $mask`"
fi
atlas="$(jq -r .atlas config.json)"
uatlas="$(jq -r .uatlas config.json)"
if [[ ($atlas != "null" || $atlas != '') && ($uatlas == "null" || $uatlas == '') ]]; then
    if [ $(echo -e "$atlas" | wc -l) -gt 1 ]; then
        optional="$optional -a"
        while IFS= read -r line ; do
            optional="$optional $line"
        done <<< "$atlas"
    else
        optional="$optional -a $atlas"
    fi
elif [[ ($atlas == "null" || $atlas == '') && ($uatlas != "null" || $uatlas != '') ]]; then
    if [ $(echo -e "$uatlas" | wc -l) -gt 1 ]; then
        optional="$optional -a"
        while IFS= read -r line ; do
            optional="$optional $line"
        done <<< `abspath "$uatlas"`
    else
        optional="$optional -a `abspath $uatlas`"
    fi
elif [[ ($atlas != "null" || $atlas != '') && ($uatlas != "null" || $uatlas != '') ]]; then
    if [ $(echo -e "$uatlas" | wc -l) -gt 1 ]; then
        optional="$optional -a"
        while IFS= read -r line ; do
            optional="$optional $line"
        done <<< `abspath "$uatlas"`
    else
        optional="$optional -a `abspath $uatlas`"
    fi
    if [ $(echo -e "$atlas" | wc -l) -gt 1 ]; then
        optional="$optional "
        while IFS= read -r line ; do
            optional="$optional $line"
        done <<< "$atlas"
    else
        optional="$optional $atlas"
    fi
fi
min_thr=$(jq -r .min_thr config.json)
max_thr=$(jq -r .max_thr config.json)
step_thr=$(jq -r .step_thr config.json)
thr=$(jq -r .thr config.json)
if [[ $min_thr != "null" ]]; then
    optional="$optional -min_thr $min_thr"
    optional="$optional -max_thr $max_thr"
    optional="$optional -step_thr $step_thr"
else
    optional="$optional -thr $thr"
fi
[ "$(jq -r .mst config.json)" == "true" ] && optional="$optional -mst"
[ "$(jq -r .dt config.json)" == "true" ] && optional="$optional -dt"
[ "$(jq -r .embed config.json)" == "true" ] && optional="$optional -embed"
[ "$(jq -r .df config.json)" == "true" ] && optional="$optional -df"
[ "$(jq -r .plt config.json)" == "true" ] && optional="$optional -plt"
[ "$(jq -r .bin config.json)" == "true" ] && optional="$optional -bin"
[ "$(jq -r .spheres config.json)" == "true" ] && optional="$optional -spheres"
prune=$(jq -r .p config.json)
if [[ "$prune" != "null" ]]; then
    optional="$optional -p $prune"
fi
norm=$(jq -r .norm config.json)
if [[ "$norm" != "null" ]]; then
    optional="$optional -norm $norm"
fi
mplx=$(jq -r .mplx config.json)
if [[ "$mplx" != "null" ]]; then
    optional="$optional -mplx $mplx"
fi
rsn=$(jq -r .n config.json)
if [[ "$rsn" != "null" ]]; then
    if [ $(echo -e "$rsn" | wc -l) -gt 1 ]; then
        optional="$optional -n"
        while IFS= read -r line ; do
            optional="$optional $line"
        done <<< "$rsn"
    else
        optional="$optional -n $rsn"
    fi
fi
es=$(jq -r .es config.json)
if [[ "$es" != "null" ]]; then
    if [ $(echo -e "$es" | wc -l) -gt 1 ]; then
        optional="$optional -es"
        while IFS= read -r line ; do
            optional="$optional $line"
        done <<< "$es"
    else
        optional="$optional -es $es"
    fi
fi
sm=$(jq -r .sm config.json)
if [[ "$sm" != "null" ]]; then
    if [ $(echo -e "$sm" | wc -l) -gt 1 ]; then
        optional="$optional -sm"
        while IFS= read -r line ; do
            optional="$optional $line"
        done <<< "$sm"
    else
        optional="$optional -sm $sm"
    fi
fi
hp=$(jq -r .hp config.json)
if [[ "$hp" != "null" ]]; then
    if [ $(echo -e "$hp" | wc -l) -gt 1 ]; then
        optional="$optional -hp"
        while IFS= read -r line ; do
            optional="$optional $line"
        done <<< "$hp"
    else
        optional="$optional -hp $hp"
    fi
fi
dg=$(jq -r .dg config.json)
if [[ "$dg" != "null" ]]; then
    if [ $(echo -e "$dg" | wc -l) -gt 1 ]; then
        optional="$optional -dg"
        while IFS= read -r line ; do
            optional="$optional $line"
        done <<< "$dg"
    else
        optional="$optional -dg $dg"
    fi
fi
ml=$(jq -r .ml config.json)
if [[ "$ml" != "null" ]]; then
    if [ $(echo -e "$ml" | wc -l) -gt 1 ]; then
        optional="$optional -ml"
        while IFS= read -r line ; do
            optional="$optional $line"
        done <<< "$ml"
    else
        optional="$optional -ml $ml"
    fi
fi
em=$(jq -r .em config.json)
if [[ "$em" != "null" ]]; then
    if [ $(echo -e "$em" | wc -l) -gt 1 ]; then
        optional="$optional -em"
        while IFS= read -r line ; do
            optional="$optional $line"
        done <<< "$em"
    else
        optional="$optional -em $em"
    fi
fi
if [ -z "$ses" ]; then
    id="$sub"
else
    id="$sub"_"$ses"
fi
echo "\n\n\n\n"$id"\n\n\n\n"
if [ ! -z $SCRATCH ]; then
    WORKINGDIR=$SCRATCH
elif [ ! -z $SINGULARITY_CACHEDIR ]; then
    mkdir -p $SINGULARITY_CACHEDIR/tmp_sifs
    WORKINGDIR=$SINGULARITY_CACHEDIR/tmp_sifs
elif [ ! -z $WORK ]; then
    WORKINGDIR=$WORK
else
    mkdir -p /var/lib/singularity
    WORKINGDIR=/var/lib/singularity
fi
if [ ! -f $WORKINGDIR/sing_pynets.sif ]; then
    singularity build $WORKINGDIR/sing_pynets.sif docker://dpys/pynets:49ec611cce24736cc7ca14db0b5fe828c464dde5
fi
cp $WORKINGDIR/sing_pynets.sif $WORKINGDIR/sing_pynets_"$id".sif
mkdir -p "$PWD"/tmp
export SINGULARITY_TMPDIR=$WORKINGDIR
singularity exec --cleanenv $WORKINGDIR/sing_pynets_"$id".sif pynets \
    "$PWD"/output \
    -id $id \
    -anat `abspath $t1w` \
    -work /tmp/work \
    -mod $(jq -r .mod config.json) \
    -plug 'MultiProc' \
    -pm '24,56' \
    $optional
rm -rf /tmp/work/*
