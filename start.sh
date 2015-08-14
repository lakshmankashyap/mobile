#!/bin/sh

root=~/prod/mobile
sails=`which sails`

forever start --workingDir ${root} -a -l mobile.log ${sails} lift --prod