#!/bin/bash

chimera --nogui 3bin_chimera.com > 3bin_compare.log &
sleep 10
chimera --nogui 4bin_chimera.com > 4bin_compare.log &
sleep 10
chimera --nogui 5bin_chimera.com > 5bin_compare.log

