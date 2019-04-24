package RaptoDo::Model::TodoTxt::Item;
use Mojo::Base '-base';

use overload (
  '""'     => sub { shift->to_string },
  fallback => 1,
);

has text => '';

sub new {
  my $class = shift;
  my $self = $class->SUPER::new;
  return @_ ? $self->_parse(shift) : $self;
}

sub to_string {
  my $self = shift;

  return $self->text;
}

sub _parse {
  my ($self, $string) = @_;

  return $self->text($string);
}

1;
