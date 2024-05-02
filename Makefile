
build:
	@chmod +x docker-entrypoint.sh
	@docker compose build

start: build
	@docker compose up --build --force-recreate gsb


test-insert:
	@bash tests/insert-test.sh
