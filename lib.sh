#!/bin/bash
function usage(){
  echo "Must invoke script with -f option; possible args are:"
  echo "- monthly"
  echo "- weekly"
  echo "- daily"
  echo "- fifteen"

  exit 1
}

function checkfreq(){
  [[ $frequency ]] || (
    echo "frequency not set; error somewhere";
    exit 1
    )
  case $frequency in
    monthly) ;;
    weekly) ;;
    daily) ;;
    fifteen) ;;
    *) usage ;;
  esac
}

function launcher(){
  pidname $1
  createpid && (
      trap "rm -f ${selfpath}/${frequency}/${pid}" 0 1 2 3 15
      /bin/bash $1
      if [[ $? == 0 ]]; then
        echo "[`TZ='Europe/Rome' date`] $1 execution went ok" | tee -a $log
      else
        echo "[`TZ='Europe/Rome' date`] $1 execution went BAD" | tee -a $log
      fi
    ) 
}

function pidname(){
  pid="$(basename $1 .sh).pid"
}

function checkpid(){
  [[ -e ${selfpath}/${frequency}/${pid} ]] && return 1 || echo "creating pid";
}

function createpid(){
  if [[ `checkpid` ]]; then
    touch ${selfpath}/${frequency}/${pid}
    return 0
  else
    echo "Script already running: pid ${frequency}/${pid} alredy present" >> ${selfpath}/fakecron.log 2>&1
    return 1
  fi
}
