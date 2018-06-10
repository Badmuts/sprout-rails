build:
	@docker-compose -f docker-compose.yml build
	@docker-compose build

release:
	@echo "This is the release script..."

dev:
	@docker-compose up