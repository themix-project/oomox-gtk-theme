SASS=sassc
SASSFLAGS= -I
GLIB_COMPILE_RESOURCES=glib-compile-resources

RES_DIR=gtk-3.0
SCSS_DIR=$(RES_DIR)/scss
DIST_DIR=$(RES_DIR)/dist
#
RES_DIR320=gtk-3.20
SCSS_DIR320=$(RES_DIR320)/scss
DIST_DIR320=$(RES_DIR320)/dist
#
RES_DIR_CINNAMON=cinnamon
SCSS_DIR_CINNAMON=$(RES_DIR_CINNAMON)/scss
DIST_DIR_CINNAMON=$(RES_DIR_CINNAMON)

# GTK3 ########################################################################

$(DIST_DIR):
	mkdir -p $@

$(DIST_DIR)/gtk.css: $(DIST_DIR)
	$(SASS) $(SASSFLAGS) "$(SCSS_DIR)" "$(SCSS_DIR)/gtk.scss" $@

$(DIST_DIR)/gtk-dark.css: $(DIST_DIR)/gtk.css
ifneq ("$(wildcard $(SCSS_DIR)/gtk-dark.scss)","")
	$(SASS) $(SASSFLAGS) "$(SCSS_DIR)" "$(SCSS_DIR)/gtk-dark.scss" $@
else
	cp "$(DIST_DIR)/gtk.css" $@
endif

css_gtk3: $(DIST_DIR)/gtk.css $(DIST_DIR)/gtk-dark.css

$(RES_DIR)/gtk.gresource.xml:
	$(GLIB_COMPILE_RESOURCES) --sourcedir="$(RES_DIR)" $@

gresource_gtk3: css_gtk3 $(RES_DIR)/gtk.gresource.xml

gtk3:
	$(MAKE) clean
	$(MAKE) gresource_gtk3

# GTK3.20+ ####################################################################

$(DIST_DIR320):
	mkdir -p $@

$(DIST_DIR320)/gtk.css: $(DIST_DIR320)
	$(SASS) $(SASSFLAGS) "$(SCSS_DIR320)" "$(SCSS_DIR320)/gtk.scss" $@

$(DIST_DIR320)/gtk-dark.css: $(DIST_DIR320)/gtk.css
ifneq ("$(wildcard $(SCSS_DIR320)/gtk-dark.scss)","")
	$(SASS) $(SASSFLAGS) "$(SCSS_DIR320)" "$(SCSS_DIR320)/gtk-dark.scss" $@
else
	cp "$(DIST_DIR320)/gtk.css" $@
endif

css_gtk320: $(DIST_DIR320)/gtk-dark.css $(DIST_DIR320)/gtk.css

$(RES_DIR320)/gtk.gresource.xml:
	$(GLIB_COMPILE_RESOURCES) --sourcedir="$(RES_DIR320)" $@

gresource_gtk320: css_gtk320 $(RES_DIR320)/gtk.gresource.xml

gtk320:
	$(MAKE) clean
	$(MAKE) gresource_gtk320

# Cinnamon ####################################################################

$(DIST_DIR_CINNAMON):
	mkdir -p $@

$(DIST_DIR_CINNAMON)/cinnamon.css: $(DIST_DIR_CINNAMON)
	$(SASS) $(SASSFLAGS) "$(SCSS_DIR_CINNAMON)" "$(SCSS_DIR_CINNAMON)/cinnamon.scss" $@

css_cinnamon: $(DIST_DIR_CINNAMON)/cinnamon.css

# Common ######################################################################

clean:
	rm -rf "$(DIST_DIR)"
	rm -f "$(RES_DIR)/gtk.gresource"
	rm -rf "$(DIST_DIR320)"
	rm -f "$(RES_DIR320)/gtk.gresource"

all_gtk: gresource_gtk3 gresource_gtk320

all:
	$(MAKE) clean
	$(MAKE) all_gtk css_cinnamon

.PHONY: all
.PHONY: clean

.DEFAULT_GOAL := all

# vim: set ts=4 sw=4 tw=0 noet :
