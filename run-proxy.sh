#!/bin/bash

CONTAINERNAME="ubuntu-proxy"
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

Help()
{
   # Display Help
   echo "Wrapper script to run a client system to reach other containers"
   echo
   echo "Syntax: run-proxy.sh [-b|r|n|h]"
   echo "options:"
   echo "-h|--help     Print this Help."
   echo "-b|--build    Build the application."
   echo "-r|--run      Run the application"
   echo "-n|--network  docker network to connect(only single existing)"
   echo
}

CmdRun()
{
    POSITIONAL=()
    while [[ $# -gt 0 ]]
    do
    key="$1"

    case $key in
        -b |--build)
        BUILD=1
        shift # past argument
        ;;

        -r|--run)
        RUN=1
        shift # past argument
        ;;

        -n|--network)
        NETWORK="$2"
        shift # past argument
        shift # past value
        ;;

        -h|--help)
        Help
        exit 0
        ;;

        *)    # unknown option
        POSITIONAL+=("$1") # save it in an array for later
        shift # past argument
        ;;
    esac
    done
    set -- "${POSITIONAL[@]}" # restore positional parameters

    if [ ! -z "$NETWORK" ] ; then
	echo "Using the existing docker network ${NETWORK}"
	NETWORK="--network=${NETWORK}"
    fi

    if [[ "${BUILD}" -eq 1 ]] ; then
        echo "Building the proxy container."
        cd ${SCRIPTPATH}; docker build -t ${CONTAINERNAME} . 
    fi

    if [[ "${RUN}" -eq 1 ]] ; then
        echo "Running the proxy container"
        cd ${SCRIPTPATH}; docker run -it ${NETWORK} -v ${PWD}/volume:/volume ${CONTAINERNAME} /volume/run-report-gen.sh
    fi
}

main()
{
    Help
    CmdRun "$@"
}

main  "$@"
