# Set up gh CLI completions
if command -v gh &> /dev/null; then
  eval "$(gh completion -s bash)"
fi
