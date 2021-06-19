#!/bin/sh
# Description:	Bootstrap the dotfiles
#


#---- Variables ----------------------------------------------------------------
bname=$(basename $0)
rdir=$(realpath $(dirname $0) )			# dotfiles repository directory
bdir=$HOME/dotfiles_backup/$(date "+%Y-%m-%d_%H%M%S")	# old dotfiles backup directory

#---- Main ---------------------------------------------------------------------
IFS=$'\n'
# Get Symlinks
links=$(find $rdir -type l -path "$rdir/.*" ! -path "*/.git*" -printf "%P\n")
# Synthesis a list of file to link to
files=$(find $rdir -type f -path "$rdir/.*" ! -path "*/.git*" -printf "%P\n")


# Backup Direcotry
echo "Backing-up the existing dotfiles to the directory: '$rdir'"
all_files=$links$'\n'$files
for file in $all_files; do
	tdir="$bdir/$(dirname $file)"
	mkdir -p $tdir
	mv -f "$HOME/$file" "$bdir/$file" 2>/dev/null
done

# Create directory structure for the configuration repository
echo "Creating the 'dotfiles' directory structure..."
find $rdir -type d ! -path "*/.git*" |  \
	sed "s|$rdir|$HOME|g" |	    \
	xargs mkdir -p

# Copy symlinks
echo "Copying symlinks from '$rdir' to '$HOME'"
for link in $links; do
	cp -P "$rdir/$link" "$HOME/$link"
done

# Create the symlinks of files
echo "Creating symlinks in '$HOME'..."
for file in $files; do
	ln -s "$rdir/$file" "$HOME/$file"
done

# Save the repo directory in the configuration directory
echo -n $rdir > $HOME/.config/repo_dir
