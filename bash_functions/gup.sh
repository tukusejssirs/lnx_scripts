#!/bin/bash
function gup(){
	git add --all
	git commit -am "$@"
	git push
}