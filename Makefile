export:
	firebase emulators:export data/

start:
	firebase emulators:start --import=data/ --export-on-exit=data/