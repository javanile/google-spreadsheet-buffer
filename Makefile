
build:
	@chmod +x docker-entrypoint.sh
	@docker compose build

start: build
	@docker compose up --build --force-recreate gsb

test-insert:
	@bash tests/insert-test.sh

test-errors:
	@bash tests/errors-test.sh

test-info:
	@bash tests/info-test.sh

