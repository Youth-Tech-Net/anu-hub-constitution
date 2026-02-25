DOCS ?= constitution policies

XSLTNG_VERSION ?= 2.1.9

XSLTNG_JAR = xsltng/libs/docbook-xslTNG-$(XSLTNG_VERSION).jar

all: html

html: $(DOCS:%=html/%.html) resources

$(XSLTNG_JAR):
	rm -rf xsltng
	curl -LO "https://github.com/docbook/xslTNG/releases/download/$(XSLTNG_VERSION)/docbook-xslTNG-$(XSLTNG_VERSION).zip"
	unzip docbook-xslTNG-$(XSLTNG_VERSION).zip
	rm -f docbook-xslTNG-$(XSLTNG_VERSION).zip
	mv docbook-xslTNG-$(XSLTNG_VERSION) xsltng
	touch $@

%-revhistory.xml: %.xml
	git log --pretty=tformat:"%H%n%h%n%as%n%s" -- $< | java -cp $(XSLTNG_JAR) net.sf.saxon.Transform -xsl:revhistory.xsl -it -o:$@ file=/dev/stdin

html/%.html: %.xml %-revhistory.xml cssa.xsl $(XSLTNG_JAR)
	java -jar $(XSLTNG_JAR) -xsl:cssa.xsl $< -o:$@

resources: cssa.css index.html $(XSLTNG_JAR)
	rm -rf html/css html/js
	cp -R xsltng/resources/css xsltng/resources/js html
	cp cssa.css html/css
	cp index.html html/index.html

clean:
	rm -f *-revhistory.xml
	rm -rf html

distclean: clean
	rm -rf xsltng

.PHONY: all html resources clean distclean
