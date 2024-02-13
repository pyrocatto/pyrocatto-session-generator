CURRENT_VERSION = $(shell cat version.txt)

.PHONY: install publish new-release new-tag delete-tag new-version

install:
	poetry install

publish:
	poetry build
	poetry publish

new-tag:
	git tag $(CURRENT_VERSION)
	git push origin $(CURRENT_VERSION)

delete-tag:
	git tag -d $(CURRENT_VERSION)
	git push origin -d $(CURRENT_VERSION)

new-release: | publish new-tag

new-version:
	sed -E 's/^"(\w|\d|\.)+"/"${V}"/' -i version.txt
	sed -E 's/version = "(\w|\d|\.)+"/version = "${V}"/' -i pyproject.toml
	sed -E 's/__version__ = "(\w|\d|\.)+"/__version__ = "${V}"/' -i pyrocatto_session_generator/__init__.py
