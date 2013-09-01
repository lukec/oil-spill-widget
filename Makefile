TARGET_DIR=/var/www/spill-widget

JS_SRC=src/lib/zepto.min.js \
       src/lib/moment.min.js \
       build/spill.js

JS=build/spill-counter.js

build/spill.js: src/spill.coffee
	coffee --compile --output build src/spill.coffee

$(JS): $(JS_SRC)
	cp src/lib/zepto.min.js $(JS)
	echo ";" >> $(JS)
	cat src/lib/moment.min.js >> $(JS)
	cat build/spill.js >> $(JS)

all: $(JS)

install: clean $(JS)
	sudo cp etc/nginx/spill-widget.conf /etc/nginx/sites-available
	sudo ln -fs /etc/nginx/sites-available/spill-widget.conf /etc/nginx/sites-enabled
	sudo /etc/init.d/nginx reload
	cp index.html $(TARGET_DIR)
	cp $(JS) $(TARGET_DIR)

clean:
	rm build/*
