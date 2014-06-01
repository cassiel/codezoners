# Building and Testing with Jasmine

	sudo npm install -g jasmine-node

Subdirectory `src` for sources, `spec` for tests ("specifications").

Then, with `xxxxspec.coffee` files in the subdirectory `spec`, do:

	jasmine-node --verbose --color --autotest --watch src --coffee .
