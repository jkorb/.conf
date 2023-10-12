#! /usr/bin/env bash

if hyprctl devices | grep -q olkb-planck; then
  hyprctl switchxkblayout olkb-planck next
fi

hyprctl switchxkblayout at-translated-set-2-keyboard next
