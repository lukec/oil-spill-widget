install:
	sudo cp etc/nginx/spill-widget.conf /etc/nginx/sites-available
	sudo ln -fs /etc/nginx/sites-available/spill-widget.conf /etc/nginx/sites-enabled
	sudo /etc/init.d/nginx reload
	cp index.html /var/www/spill-widget
	cp spill-counter.js /var/www/spill-widget
