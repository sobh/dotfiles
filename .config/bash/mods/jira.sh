# Dynamically extract Jira ticket on directory change
_update_jira_issue() {
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
# Append to PROMPT_COMMAND so it runs every time the prompt renders
if [[ ! "$PROMPT_COMMAND" =~ _update_jira_issue ]]; then
    PROMPT_COMMAND="_update_jira_issue;$PROMPT_COMMAND"
fi
