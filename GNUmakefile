cramcmd = cram
cram =
tests = t

.PHONY: all
all: bsd-up

bsd-up: s/bsd-up.zsh
	install -m 755 $< $@

.PHONY: check
check: bsd-up
	env -i BUILDDIR="$$PWD" PATH="$$PATH" $(cramcmd) $(cram) $(tests)

.PHONY: clean
clean:
	rm -f bsd-up *.1 *.html *.tmp $(testdir)/*.err

.PHONY: install
install: all | installdirs
	install -d -m 755 $(DESTDIR)$(bindir)
	install -m 755 $< $(DESTDIR)$(bindir)/$@

.PHONY: installdirs
installdirs:
	mkdir -p $(DESTDIR)$(bindir)
	mkdir -p $(DESTDIR)$(man1dir)
