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

.PHONY: download_nginx_config
download_nginx_config:
	scp www.paulfurley.com:/etc/nginx/sites-enabled/paulfurley.com* _config/nginx/
	scp www.paulfurley.com:/etc/nginx/sites-enabled/www.paulfurley.com* _config/nginx/

.PHONY: 309F635DAD1B5517.public.asc
309F635DAD1B5517.public.asc:
	gpg --export-options export-minimal,export-clean --armor --export 0xA999B7498D1A8DC473E53C92309F635DAD1B5517 > $@
