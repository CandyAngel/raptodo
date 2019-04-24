package RaptoDo::Model::TodoTxt::Item;
use Mojo::Base '-base';

use overload (
  '""'     => sub { shift->to_string },
  fallback => 1,
);

has [qw(priority text)] => '';

sub new {
  my $class = shift;
  my $self = $class->SUPER::new;
  return @_ ? $self->_parse(shift) : $self;
}

sub to_string {
  my $self = shift;

  my @tokens;
  push @tokens, sprintf('(%s)', $self->priority) if $self->priority;

  return join ' ', @tokens, $self->text;
}

sub _parse {
  my ($self, $string) = @_;

  if ($string =~ s/\A \(([A-Z])\) \s//msx) {
    $self->priority($1);
  }

  return $self->text($string);
}

1;
