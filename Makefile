.PHONY: build up down install update du sniff beautify analyse report dependencygraph metrics rector test infection updatehooks all

build:
	docker compose build dummy_php

up:
	docker compose up -d

down:
	docker compose down

install:
	make up
	docker compose exec dummy_php composer install
	docker compose exec dummy_php composer install --working-dir=tools/rector

update:
	make up
	docker compose exec dummy_php composer update
	docker compose exec dummy_php composer update --working-dir=tools/rector

du:
	make up
	docker compose exec dummy_php composer du
	docker compose exec dummy_php composer du --working-dir=tools/rector

sniff:
	make up
	docker compose exec dummy_php ./vendor/bin/phpcs -w -p -s --standard=vendor/flyeralarm/php-code-validator/ruleset.xml ./src ./tests

beautify:
	make up
	docker compose exec dummy_php ./vendor/bin/phpcbf -w -p -s --standard=vendor/flyeralarm/php-code-validator/ruleset.xml ./src ./tests

analyse:
	make up
	docker compose exec dummy_php ./vendor/bin/phpstan analyse -c tools/phpstan.neon
	docker compose exec dummy_php ./vendor/bin/phpmnd --progress ./src ./tests
	docker compose exec dummy_php ./vendor/bin/deptrac analyse --config-file=tools/deptrac.yaml
	docker compose exec dummy_php ./vendor/bin/psalm --no-cache -c tools/psalm.xml

report:
	make up
	docker compose exec dummy_php ./vendor/bin/phpmetrics ./src --report-html=./report

dependencygraph:
	make up
	rm -f vendor/dettbarn/dependencygraph/output/*.png
	docker compose exec dummy_php ./vendor/bin/dependencygraph report/classes.js 'Test\DummyPhp\Root' report/package_relations.html 'Test'

metrics:
	make up
	make report
	make dependencygraph

rector:
	make up
	docker compose exec dummy_php ./tools/rector/vendor/bin/rector process --dry-run -c tools/rector.php

test:
	make up
	docker compose exec dummy_php ./vendor/bin/phpunit -c tools/phpunit.xml

infection:
	make up
	docker compose exec dummy_php ./vendor/bin/infection --configuration=tools/infection.json5

updatehooks:
	make up
	docker compose exec dummy_php ./vendor/bin/captainhook install --configuration=tools/captainhook.json

all:
	make up
	make sniff
	make metrics
	make rector
	make test
	make infection
	make analyse
