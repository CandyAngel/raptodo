package RaptoDo::Model::TodoTxt::Item;
use Mojo::Base '-base';

use overload (
  '""'     => sub { shift->to_string },
  fallback => 1,
);

has completed => 0;

has [qw(completion creation priority text)] => '';

sub new {
  my $class = shift;
  my $self = $class->SUPER::new;
  return @_ ? $self->_parse(shift) : $self;
}

sub to_string {
  my $self = shift;

  my @tokens;
  push @tokens, 'x' if $self->completed;
  push @tokens, $self->completion if $self->completion;
  push @tokens, sprintf('(%s)', $self->priority)
    if $self->priority and !$self->completed;
  push @tokens, $self->creation if $self->creation;

  return join ' ', @tokens, $self->text;
}

sub _parse {
  my ($self, $string) = @_;

  if ($string =~ s/\A (\d{4}-\d{2}-\d{2}) \s//msx) {
    $self->creation($1);
  }
  elsif ($string =~ s/\A \(([A-Z])\) \s (\d{4}-\d{2}-\d{2}) \s//msx) {
    $self->priority($1);
    $self->creation($2);
  }
  elsif ($string =~ s/\A \(([A-Z])\) \s//msx) {
    $self->priority($1);
  }
  elsif ($string =~ s/\Ax \s (\d{4}-\d{2}-\d{2}) \s (\d{4}-\d{2}-\d{2}) \s//msx ) {
    $self->completed(1);
    $self->completion($1);
    $self->creation($2);
  }
  elsif ($string =~ s/\Ax \s (\d{4}-\d{2}-\d{2}) \s//msx ) {
    $self->completed(1);
    $self->completion($1);
  }
  elsif ($string =~ s/\A x \s//msx) {
    $self->completed(1);
  }

  return $self->text($string);
}

1;
