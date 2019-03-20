tracked="/tmp/tracked"
untracked="/tmp/untracked"

mkdir /tmp/{tracked,untracked}

### orig
while read branch; do
#   upstream=$(git rev-parse --abbrev-ref $branch@{upstream} 2>/dev/null)
#   if [[ $? == 0 ]]; then
#     echo $branch tracks $upstream
#   else
#     echo $branch has no upstream configured
#   fi
# done < <(git for-each-ref --format='%(refname:short)' refs/heads/*)

### mdfd
# while read branch; do
# 	upstream=$(git rev-parse --abbrev-ref $branch@{upstream} 2>/dev/null)
# 	if [[ $? == 0 ]]; then
# 		echo $branch tracks $upstream >> /tmp/tracked
# 	else
# 		echo $branch >> /tmp/untracked
# 	fi
# done < <(git for-each-ref --format='%(refname:short)' refs/heads/*)

remote_branches=$(git branch -r)

# If remote branch does not exist locally, create it
for r in $remote_branches; do
	branch_name=$(echo $r | grep -o "[^/]*$")
	branch_test=$(git branch --list $branch_name)
	if [[ $branch_name != $branch_test ]]; then
		git checkout --track $r
	else
		is_tracking=$(git rev-parse --abbrev-ref $branch_name@{upstream} | echo $?)
		if [[ $is_tracking != 0 ]]; then
			git checkout --track $r
	fi
done

# rm -rf /tmp/{tracked,untracked}