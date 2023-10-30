#!/bin/bash -e

old_version="v6.5.x"
version="v6.6.x"

run_new () {
	git clone git@github.com:RobertCNelson/${git_project}.git ${project}
	cd ./${project}/
	git checkout origin/${old_version} -b ${version}
	cd ../
}

run () {
	project="${git_project}"
	branch="${version}"
	if [ -d ./${project} ] ; then
		rm -rf ./${project} || true
	fi

	git clone -b ${branch} git@github.com:RobertCNelson/${git_project}.git ${project} --depth=1
	#run_new
}

git_project="arm64-mainline-linux" ; run
git_project="imx_v6_v7-mainline-linux" ; run
git_project="multi_v7-mainline-linux" ; run
git_project="omap2plus-mainline-linux" ; run
git_project="riscv64-mainline-linux" ; run
#
