use IO::File;


sub become_daemon
{
	my ($script_dir,$user,$group) = @_;
	die "Can't fork" unless defined (my $child = fork);
	exit 0 if $child;
	setsid();
	open STDIN,"</dev/null";
	open STDOUT,">/dev/null";
	#open STDERR,">/dev/null";
	open STDERR,">>$dir/logs/error.log";
	chdir $script_dir;
	my $uid = getpwnam($user);
	my $gid = getgrnam($group);
	$> = $uid;
	#$< = $uid;
	$) = "$gid $gid";
#	umask(022);
#	$ENV{PATH} = '/bin:/sbin:/usr/bin:/usr/sbin';
	return $$;
}

sub open_pid_file
{
	my $pid_file = shift;
	if(-e $pid_file)
	{
		open PID_FILE,"<$pid_file" or die "Can't open $pid_file:$!";
		my $pid = <PID_FILE>;
		close PID_FILE;

		unless(defined($pid))
		{
			die "Can't remove $pid_file\n" unless -w $pid_file && unlink $pid_file;
			return IO::File->new($pid_file,O_WRONLY|O_CREAT|O_EXCL,0644) or die "Can't create $pid_file:$!\n";
		}

		die "Process is still run\n" if kill 0=>$pid;
		die "Can't remove $pid_file\n" unless -w $pid_file && unlink $pid_file;
	}
	return IO::File->new($pid_file,O_WRONLY|O_CREAT|O_EXCL,0644) or die "Can't create $pid_file:$!\n";
	
}

1;
