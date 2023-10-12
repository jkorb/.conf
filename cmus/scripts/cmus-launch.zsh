#! /usr/bin/env bash

cmus_running ()
{
  cmus-remote -Q &> /dev/null
}

if ! cmus_running; then
  alacritty -T cmus -e cmus &!
fi

until cmus_running
do
  sleep 0.1
done

if [ ! $# -eq 0 ]; then
  cmus-remote -f $@
fi

