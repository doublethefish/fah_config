#!/bin/sh
# Enables using opendiff as the tool for svn-diff

DIFF="$(which opendiff)"
$DIFF $6 $7
