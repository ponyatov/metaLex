# \ <section:var>
MODULE       = metaL
#              $(notdir $(CURDIR))
OS           = $(shell uname -s)
MACHINE      = $(shell uname -m)
NOW          = $(shell date +%d%m%y)
REL          = $(shell git rev-parse --short=4 HEAD)
# / <section:var>
# \ <section:dir>
CWD          = $(CURDIR)
BIN          = $(CWD)/bin
SRC          = $(CWD)/src
TMP          = $(CWD)/tmp
# / <section:dir>
# \ <section:tool>
WGET         = wget -c
CURL         = curl
IEX          = $(shell which iex)
MIX          = $(shell which mix)
ERL          = $(shell which erl)
# / <section:tool>
# \ <section:src>
S += $(X)
# / <section:src>
# \ <section:all>
.PHONY: all web
all web: $(MIX)
	$<

.PHONY: format
format: $(MIX)
	$< $@

.PHONY: repl
repl: $(MIX)
	$< $@

.PHONY: test
test: $(MIX)
	$< $@
# / <section:all>
# \ <section:install>
.PHONY: install
install: $(OS)_install js
.PHONY: update
update: $(OS)_update
.PHONY: Linux_install Linux_update
Linux_install Linux_update:
	sudo apt update
	sudo apt install -u `cat apt.txt`
# / <section:install>
# \ <section:merge>
MERGE  = Makefile README.md .vscode $(S)
MERGE += apt.txt
.PHONY: main
main:
	git push -v
	git checkout $@
	git pull -v
	git checkout shadow -- $(MERGE)
.PHONY: shadow
shadow:
	git push -v
	git checkout $@
	git pull -v
.PHONY: release
release:
	git tag $(NOW)-$(REL)
	git push -v && git push -v --tags
	$(MAKE) shadow
.PHONY: zip
zip:
	git archive \
		--format zip \
		--output $(TMP)/$(MODULE)_$(NOW)_$(REL).src.zip \
	HEAD
# / <section:merge>
