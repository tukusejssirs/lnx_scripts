#!/bin/bash
function gups(){
	git add --all
	git commit -am "$@"
	git push
}