sub config_mysql
{
	my($dbh,$sth) = @_;
	my $config;
	if (!$sth) 
	{
      		die "Error:" . $dbh->errstr . "\n";
  	}
  	if (!$sth->execute) 
	{
      		die "Error:" . $sth->errstr . "\n";
  	}
  	my $names = $sth->{'NAME'};
  	my $numFields = $sth->{'NUM_OF_FIELDS'};
  	while (my $ref = $sth->fetchrow_arrayref) 
	{
      		for (my $i = 0;  $i < $numFields;  $i++) 
		{
			$config->{$$names[$i]} = $$ref[$i];
      		}
  	}
	return $config;
}


sub config_file
{
	my ($config_file) = @_; 
        open CONFIG,"<$config_file" or die "Cant't open $config_file:$!";
        my $config;
        while(<CONFIG>)
        {
                next if (/^$/||/^\s*\#/);
                chomp;
		s/(\#.*$|\s)//g;
                my($key,$value) = split/=/;
                $config->{$key} = $value;
        }
        close CONFIG;
        return $config;
}

1;

