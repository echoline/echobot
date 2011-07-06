+ weather *
- <call>weather <star></call>

> object weather perl
	use Yahoo::Weather;

	my ($rs, @args) = @_;
	my $loc = join(' ', @args);

	my $weather = Yahoo::Weather->new();
	my $forecast = $weather->getWeatherByLocation($loc, 'F');

	return "Temperature in " . $forecast->{'LocationDetails'}->{'city'} .
		" is " . $forecast->{'CurrentObservation'}->{'temp'} . 
		" degrees fahrenheit.  Conditions are " .
		$forecast->{'CurrentObservation'}->{'text'} . ".  ";
< object

+ [*] weather [like] in *
@ weather <star>

+ [*] forecast for *
@ weather <star>

+ [*] weather for *
@ weather <star>

