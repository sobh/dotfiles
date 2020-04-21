#!/bin/dash
# Description:	Bootstrap the dotfiles
#


#---- Variables ----------------------------------------------------------------
bname=$(basename $0)
repo_dir=$(dirname $0)			# dotfiles repository directory
backup_dir=$HOME/dotfiles_backup/$(date "+%Y-%m-%d_%H%M%S")	# old dotfiles backup directory

target_dir=$HOME
ignored_files="($bname|\.git|README|TODO|LICENSE)"

#---- The money shot -----------------------------------------------------------
cd $repo_dir
# Synthesis a list of file to link to
files=$(ls --almost-all | egrep -v $ignored_files)
files_path=$(realpath --no-symlinks $files)

# Backup
echo "Creating '$backup_dir' for backup of any existing dotfiles in $target_dir ..."
mkdir -pv $backup_dir
cd $target_dir
for file in $files; do
	mv -vf "$file" $backup_dir 2>&1 1>/dev/null
done
# Create the symlinks
echo "Creating symlinks in '$target_dir'..."
ln -s $files_path $target_dir

