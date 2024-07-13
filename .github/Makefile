# Makefile

# Default labels file
LABELS_FILE=labels.json

# Target to sync labels
sync-labels:
	@echo "Syncing labels for repository $(REPO)..."
ifndef GITHUB_ACCESS_TOKEN
	$(error GITHUB_ACCESS_TOKEN is undefined)
endif
ifndef REPO
	$(error REPO is undefined)
endif
	github-label-sync --access-token $(GITHUB_ACCESS_TOKEN) --labels $(LABELS_FILE) $(REPO)
	@echo "Labels sync completed."

# Help target
help:
	@echo "Usage:"
	@echo "  make sync-labels GITHUB_ACCESS_TOKEN=<your_token> REPO=<your_repo>"
	@echo ""
	@echo "This target syncs the labels defined in labels.json with the specified GitHub repository."

# .PHONY to avoid conflict with file names
.PHONY: sync-labels help
