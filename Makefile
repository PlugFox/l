.PHONY: format get upgrade outdated analyze deploy coverage

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

check: analyze
	@dart pub global activate pana
	@pana --json --warning --line-length 80 > log.pana.json

deploy:
	@echo "Publish"
	@dart pub publish

coverage:
	@dart test --concurrency=6 --platform vm --coverage=coverage test/
	@dart run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info --packages=.packages --report-on=lib
	#@mv coverage/lcov.info coverage/lcov.base.info
	#@lcov -r coverage/lcov.base.info -o coverage/lcov.base.info "lib/**.freezed.dart" "lib/**.g.dart"
	#@mv coverage/lcov.base.info coverage/lcov.info
	@lcov --list coverage/lcov.info
	@genhtml -o coverage coverage/lcov.info
