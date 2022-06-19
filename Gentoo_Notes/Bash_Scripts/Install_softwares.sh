softwares_array=(
"app-misc/neofetch"
"sys-process/htop"
"app-portage/gentoolkit"
"app-eselect/eselect-repository"
)

emaint -a sync
for software in ${softwares_array[@]}; do
  emerge -q $software
done