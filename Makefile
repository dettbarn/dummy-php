up:
	docker compose build
	docker compose up -d

sniff:
	docker exec php ./vendor/bin/phpcs ./src

beautify:
	docker exec php ./vendor/bin/phpcbf ./src

report:
	docker exec php ./vendor/bin/phpmetrics ./src
