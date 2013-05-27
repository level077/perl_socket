sub write_log
{
	my $fh = shift;
	my @info = @_;
	my $cur_time = localtime;
	print $fh "$cur_time	@info\n";
}


sub write_error_log
{
	my $error_log = $dir.'/var/log/error_log';
	my $error_info = shift;
	my $cur_time = localtime;
	$error_info = "[$cur_time]: ".$error_info."\n";
	open ERROR_LOG,">>$error_log";
	print ERROR_LOG $error_info;
	close ERROR_LOG;
}


1;
