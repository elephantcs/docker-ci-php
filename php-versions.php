<?php
/**
 * Small script that fetches the latest versions in the Launchpad
 */
$file = @file_get_contents( 'https://launchpad.net/~ondrej/+archive/ubuntu/php/+index?batch=75&direction=backwards&memo=375&start=300' );
if ( ! preg_match_all( '~<tr[^>]+>(?:.|\n)+</tr>~imU', $file, $rows, PREG_SET_ORDER ) ) {
	echo 'echo "Failed to fetch versions!"';
	exit( 1 );
}


foreach ( $rows as $row ) {
	$row = $row[0];
	if ( ! preg_match( '~\s+php\d+\.\d+\s+~', $row, $phpVersion ) ) {
		continue;
	}

	$phpVersion = trim( $phpVersion[0] );
	$phpVersionNumber = str_replace( 'php', '', $phpVersion );

	if ( ! preg_match( '~\s\S+ubuntu20.04\S+\s~', $row, $version ) ) {
		continue;
	}

	$fullVersion = trim( $version[0] );

	echo sprintf( "echo '== [%s] %s'\n", $phpVersion, $fullVersion );
	if ( file_exists( __DIR__ . '/' . $phpVersionNumber . '/' ) ) {
		echo sprintf( 'gsed -i -E \'s~install -y %s=.+$~install -y %s=%s~g\' ./%s/Dockerfile' . "\n", $phpVersion, $phpVersion, $fullVersion, $phpVersionNumber );
		echo "echo 'Updated!'\n";
	} else {
		echo sprintf( 'echo "No /%s/ folder to update"' . "\n", $phpVersionNumber );
	}
}