TARGET_DIR=/var/www/spill-widget

JS_SRC=src/lib/zepto.min.js \
       src/lib/flipcounter.js \
       src/lib/moment.min.js \
       build/spill.js

JS=build/spill-counter.js

build/spill.js: src/spill.coffee
	coffee --compile --output build src/spill.coffee

$(JS): $(JS_SRC)
	echo "/* Spill Widget: https://github.com/lukec/oil-spill-widget - Compiled on:" > $(JS)
	date >> $(JS)
	echo "Do not edit this file directly. */" >> $(JS)
	cat $(JS_SRC) >> $(JS)

all: $(JS)

install: clean $(JS)
	sudo cp etc/nginx/spill-widget.conf /etc/nginx/sites-available
	sudo ln -fs /etc/nginx/sites-available/spill-widget.conf /etc/nginx/sites-enabled
	sudo /etc/init.d/nginx reload
	cp index.html $(TARGET_DIR)
	cp $(JS) $(TARGET_DIR)
	cp -R img $(TARGET_DIR)
	cp -R css $(TARGET_DIR)

clean:
	rm build/*
