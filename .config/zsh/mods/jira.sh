# Dynamically extract Jira ticket on directory change
function _update_jira_issue() {
	NEW_JIRA_ISSUE=$(pwd | grep -oE '[A-Z][A-Z0-9]+-[0-9]+' | tail -n1)
	if [ "$NEW_JIRA_ISSUE" != "$JIRA_ISSUE" ]; then
		if [ -n "$NEW_JIRA_ISSUE" ]; then
			export JIRA_ISSUE=$NEW_JIRA_ISSUE
			echo "Jira Issue=$JIRA_ISSUE"
		else
			echo "-JIRA_ISSUE"
			unset JIRA_ISSUE
		fi
	fi
}
# Append to the chpwd hook array so it runs on every cd
autoload -U add-zsh-hook
add-zsh-hook chpwd _update_jira_issue
# Run once on shell startup
_update_jira_issue
