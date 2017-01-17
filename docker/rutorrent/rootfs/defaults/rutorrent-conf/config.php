<?php

	@define('HTTP_USER_AGENT', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2983.0 Safari/537.36', true);
	@define('HTTP_TIME_OUT', 30, true);
	@define('HTTP_USE_GZIP', true, true);
	$httpIP = null;

	@define('RPC_TIME_OUT', 5, true);
	@define('LOG_RPC_CALLS', false, true);
	@define('LOG_RPC_FAULTS', true, true);
	@define('PHP_USE_GZIP', false, true);
	@define('PHP_GZIP_LEVEL', 2, true);

	$schedule_rand = 10;

	$do_diagnostic = true;
	$log_file = '/logs/rutorrent/rutorrent.log';

	$saveUploadedTorrents = true;
	$overwriteUploadedTorrents = false;

	$topDirectory = '/';
	$forbidUserSettings = false;

	$scgi_port = 0;
	$scgi_host = "unix:////run/php/.rtorrent.sock";

	$XMLRPCMountPoint = "/RPC2";

	$pathToExternals = array(
		"php" 	=> '/usr/bin/php7',
		"curl"	=> '/usr/bin/curl',
		"gzip"	=> '/usr/bin/gzip',
		"id"	=> '/usr/bin/id',
		"stat"	=> '/bin/stat',
	);

	$localhosts = array(
		"127.0.0.1",
		"localhost",
	);
	$profilePath = '/config/rutorrent/profiles';
	$profileMask = 0777;
	$tempDirectory = '/config/rutorrent/profiles/tmp/';
	$canUseXSendFile = true;

	$locale = "UTF8";
