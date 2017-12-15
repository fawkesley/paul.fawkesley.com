TAG_NAME=blog

.PHONY: site
site:   lint dependencies
	bundle exec jekyll build

.PHONY: run
run: dependencies
	bundle exec jekyll serve --host 0.0.0.0 --port 4567 --force_polling

.PHONY: install
install: site
	sudo mv --backup=numbered --no-target-directory --force _site /var/www/www.paulfurley.com
	mkdir _site

.PHONY: clean
clean:
	rm -rf _site/
	mkdir _site

.PHONY: lint
lint:
	find _layouts _includes -type f -exec dos2unix {} \+
	dos2unix *.html

.PHONY: deploy
deploy: dependencies
	./_config/deploy

.PHONY: dependencies
dependencies:
	@./_config/install_deps
