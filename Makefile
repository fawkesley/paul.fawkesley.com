TAG_NAME=blog

.PHONY: site
site:   lint clean
	docker build --tag=${TAG_NAME} .
	docker run \
    --volume "${PWD}:/opt/www.paulfurley.com" \
    ${TAG_NAME} \
    jekyll build --source /opt/www.paulfurley.com --destination /opt/www.paulfurley.com/_site

.PHONY: install
install: site
	sudo mv --backup=numbered --no-target-directory --force _site /var/www/html
	mkdir _site

.PHONY: clean
clean:
	rm -rf _site/
	mkdir _site

.PHONY: lint
lint:
	find _layouts _includes -type f -exec dos2unix {} \+
	dos2unix *.html
