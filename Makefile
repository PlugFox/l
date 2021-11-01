.PHONY: format get upgrade outdated analyze deploy

format:
	@echo "Formatting the code"
	@dart format -l 80 --fix .
	@dart fix --apply .

get:
	@echo "Geting dependencies"
	@dart pub get

upgrade: get
	@echo "Upgrading dependencies"
	@flutter pub upgrade

outdated:
	@echo "Outdated check"
	@dart pub outdated

analyze: get format
	@echo "Analyze the code"
	@dart analyze --fatal-infos --fatal-warnings

deploy:
	@echo "Publish"
	@dart pub publish