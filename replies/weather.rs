+ weather *
- <call>weather <star></call>

> object weather perl
	use Yahoo::Weather;

	my ($rs, @args) = @_;
	my $loc = join(' ', @args);

	my $weather = Yahoo::Weather->new();
	my $forecast = $weather->getWeatherByLocation($loc, 'F');

	if (ref($forecast) ne "HASH") {
		return "Unable to fetch weather data for $loc.  ";
	}

	return "Temperature in " . $forecast->{'LocationDetails'}->{'city'} .
		" is " . $forecast->{'CurrentObservation'}->{'temp'} . 
		" degrees fahrenheit.  Conditions: " .
		$forecast->{'CurrentObservation'}->{'text'} . ".  ";
< object

+ [*] weather [like] in *
@ weather <star>

+ [*] forecast for *
@ weather <star>

+ [*] weather for *
@ weather <star>

