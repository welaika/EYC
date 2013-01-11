#!/bin/bash

selfpath=$(dirname $0)
log=${selfpath}/eyc.log
source ${selfpath}/lib.sh

while getopts "f:" opt; do
    case $opt in
        f) frequency=$OPTARG ;;
        *) usage ;;
    esac
done

checkfreq

for script in `ls ${selfpath}/${frequency}/*.sh`; do
  launcher $script
done
