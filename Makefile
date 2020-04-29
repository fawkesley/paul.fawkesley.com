.PHONY: site
site: clean
	cd hugo; \
	rm -rf public; \
	hugo

.PHONY: run
run:
	cd hugo; \
	hugo server --verbose --disableFastRender

.PHONY: clean
clean:
	find hugo/public/ -mindepth 1 -delete
	mkdir -p hugo/public

.PHONY: deploy
deploy: site
	rsync -razv --delete --progress --checksum hugo/public/ paul-fawkesley-com@paul.fawkesley.com:~/html

.PHONY: download_nginx_config
download_nginx_config:
	scp paul.fawkesley.com:/etc/nginx/sites-enabled/*paul.fawkesley.com* _config/nginx/
