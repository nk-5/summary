BUNDLE?=$(shell which bundle)
SWIFT_FORMAT?=$(shell which swiftformat)

install:
	$(BUNDLE) install --path=vendor/bundle
	${BUNDLE} exec pod install

format:
ifdef CI
else
	$(SWIFT_FORMAT) . --indent 4
endif
