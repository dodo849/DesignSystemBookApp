# Default labels file
LABELS_FILE=labels.json

# Target to sync labels
sync-labels:
	@echo "Syncing labels for repository $(REPO)..."
ifndef GITHUB_ACCESS_TOKEN
	$(error GITHUB_ACCESS_TOKEN is undefined)
endif
ifndef NICKNAME
	$(error NICKNAME is undefined)
endif
ifndef REPO_NAME
	$(error REPO_NAME is undefined)
endif
	github-label-sync --access-token $(GITHUB_ACCESS_TOKEN) --labels $(LABELS_FILE) $(NICKNAME)/$(REPO_NAME)
	@echo "Labels sync completed."

# Help target
help:
	@echo "Usage:"
	@echo "  make sync-labels GITHUB_ACCESS_TOKEN=<your_token> NICKNAME=<your_nickname> REPO_NAME=<your_repo_name>"
	@echo ""
	@echo "This target syncs the labels defined in labels.json with the specified GitHub repository."

# .PHONY to avoid conflict with file names
.PHONY: sync-labels help