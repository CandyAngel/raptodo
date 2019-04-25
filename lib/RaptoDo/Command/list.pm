package RaptoDo::Command::list;
use Mojo::Base 'Mojolicious::Command';

has description => 'List tasks';

has usage => sub { shift->extract_usage };

sub run {
  my $self = shift;

  my $tasks = $self->app->todotxt->items;
  $tasks->each(sub { say $_ });
}

1;

=encoding utf8

=head1 NAME

RaptoDo::Command::list - List command

=head1 SYNOPSIS

  Usage: APPLICATION list

    ./myapp.pl list

  Options:
      -h, --help  Show this summary of available options

=head1 DESCRIPTION

L<RaptoDo::Command::list> lists task entries.

=head1 ATTRIBUTES

L<RaptoDo::Command::list> inherits all attributes from L<Mojolicious::Command>
and implements the following new ones.

=head2 description

  my $description = $get->description;
  $get            = $get->description('Foo');

Short description of this command, used for the command list.

=head2 usage

  my $usage = $get->usage;
  $get      = $get->usage('Foo');

Usage information for this command, used for the help screen.

=head1 METHODS

L<RaptoDo::Command::list> inherits all methods from L<Mojolicious::Command>
and implements the following new ones.

=head2 run

  $get->run(@ARGV);

Run this command.

=head1 SEE ALSO

L<RaptoDo>, L<Mojolicious>, L<https://mojolicious.org>.

=cut
