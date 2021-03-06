#!/bin/sh

. "$JBOSS_HOME/bin/probe_common.sh"

OUTPUT=/tmp/readiness-output
ERROR=/tmp/readiness-error
LOG=/tmp/readiness-log

DEBUG=${SCRIPT_DEBUG:-false}
PROBE_IMPL="probe.eap.dmr.EapProbe probe.eap.dmr.HealthCheckProbe"

if [ $# -gt 0 ] ; then
    DEBUG=$1
fi

if [ $# -gt 1 ] ; then
    PROBE_IMPL=$2
fi

if [ "$DEBUG" = "true" ]; then
    DEBUG_OPTIONS="--debug --logfile $LOG --loglevel DEBUG"
fi

if python $JBOSS_HOME/bin/probes/runner.py -c READY $DEBUG_OPTIONS $PROBE_IMPL; then
    exit 0
fi
exit 1

