cd .devcontainer 
find . -name *.sh|grep -v setup_bundles.sh|grep -v setup_git_environments.sh|while read i; do git update-index --chmod=+x $i; done
find . -name *.ps1|while read i; do git update-index --chmod=+x $i; done
cd ../.github
find . -name *.sh|grep -v setup_bundles.sh|grep -v setup_git_environments.sh|while read i; do git update-index --chmod=+x $i; done
find . -name *.ps1|while read i; do git update-index --chmod=+x $i; done
cd ../templates
find . -name *.sh|grep -v setup_bundles.sh|grep -v setup_git_environments.sh|while read i; do git update-index --chmod=+x $i; done
find . -name *.ps1|while read i; do git update-index --chmod=+x $i; done