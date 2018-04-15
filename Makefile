BUNDLE?=$(shell which bundle)
SWIFT_FORMAT?=.Pods/SwiftFormat/CommandLineTool/swiftformat

install:
	$(BUNDLE) install --path=vendor/bundle
	${BUNDLE} exec pod install

format:
	$(SWIFT_FORMAT) ./summary --indent 4
