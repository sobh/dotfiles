#
# Purpose:	Define aliases for pacman.
#

alias pac_clean_cache="sudo pacman -Scc"	# Clean cache - delete all not currently installed package files
alias pac_expl="pacman -D --asexp"		# List # Mark one or more installed packages as explicitly installed 
alias pac_find_owner="pacman -Qo"		# Find package that owns the given file
alias pac_impl="pacman -D --asdep"		# List # Mark one or more installed packages as non explicitly installed
alias pac_in='sudo pacman -S'			# Synch# Install specific package(s) from the repositories
alias pac_ins='sudo pacman -U'			# Synch# Install specific package not from the repositories but from a file 
alias pac_loc_info='pacman -Qi'			# Synch# Display information about a given package in the local database
alias pac_loc_search='pacman -Qs'		# Synch# Search for package(s) in the local database
alias pac_ls_explicit='pacman -Qe'		# List all explicitly installed packages
alias pac_ls_files="pacman -Ql"			# List all files installed by a given package
alias pac_ls_foreign='pacman -Qm'		# List all foreign packages (typically manually downloaded and installed)
alias pac_ls_native='pacman -Qn'		#List all native packages (installed from the sync database(s)) 
alias pac_ls_orphans="pacman -Qdt"		# List all packages which are orphaned
alias pac_re='sudo pacman -R'			# Synch# Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pac_rem='sudo pacman -Rns'		# Synch# Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pac_repo_info='pacman -Sii'		# Synch# Display information about a given package in the repositories
alias pac_repo_search='pacman -Ss'		# Synch# Search for package(s) in the repositories
alias pac_upgrade='sudo pacman -Syu'		# Synchronize with repositories and then upgrade packages that are out of date on the local system.

# Additional pacman alias examples
alias pac_update='sudo pacman -Sy && sudo abs'	# Update and refresh the local package and ABS databases against repositories
alias pac_insd='sudo pacman -S --asdeps'	# Install given package(s) as dependencies
alias pac_mir='sudo pacman -Syy'	# Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

#---- Clean-up -----------------------------------------------------------------
# '[r]emove [o]rphans' - recursively remove ALL orphaned packages
alias pac_rm_orphans="pacman -Qtdq > /dev/null && sudo pacman -Rns \$(pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')"
# List explicitly installed packages not in base or base-devel with size and description
alias pac_ls_nonbase='expac -HM "%011m\t%-20n\t%10d" $( comm -23 <(pacman -Qqen|sort) <(pacman -Qqg base base-devel|sort) ) | sort -n'


