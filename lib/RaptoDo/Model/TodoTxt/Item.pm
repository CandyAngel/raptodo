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

=encoding utf8

=head1 NAME

RaptoDo::Model::TodoTxt::Item - Model for todo.txt items

=head1 SYNOPSIS

  use RaptoDo::Model::TodoTxt::Item;

  my $item = RaptoDo::Model::TodoTxt::Item->new('x 2019-04-02 feed the raptor');
  say $item->completed;
  say $item->completion;
  say $item->text;

=head1 DESCRIPTION

L<RaptoDo::Model::TodoTxt::Item> is a model for todo.txt strings, which
provides a simple API for query and modification.

=head1 ATTRIBUTES

L<RaptoDo::Model::TodoTxt::Item> implements the following attributes.

=head2 completed

  my $bool = $item->completed;
  $item    = $item->completed(1);

Completion state of the item, defaults to 0.

=head2 completion

  my $date = $item->completion;
  $item    = $item->completion('2019-04-02');

Completion date of the item, defaults to an empty string.

=head2 creation

  my $date = $item->creation;
  $item    = $item->creation('2019-04-01');

Creation date of the item, defaults to an empty string.

=head2 priority

  my $priority = $item->priority;
  $item        = $item->priority('A');

Priority of the item, defaults to an empty string.

=head2 text

  my $text = $item->text;
  $item    = $item->text('feed the raptor');

Text of the item, defaults to an empty string.

=head1 METHODS

L<RaptoDo::Model::TodoTxt::Item> inherits all methods from L<Mojo::Base>
and implements the following new ones.

=head2 new

  my $item = RaptoDo::Model::TodoTxt::Item->new;
  my $item = RaptoDo::Model::TodoTxt::Item->new('x feed the raptor');

Construct a new L<RaptoDo::Model::TodoTxt::Item> object and parse the string
if necessary.

=head2 to_string

  my $str = $item->to_string;

Stringify the item.

=head1 OPERATORS

L<RaptoDo::Model::TodoTxt::Item> overloads the following operators.

=head2 stringify

  my $str = "$item";

Alias for L</"to_string">.

=head1 SEE ALSO

L<RaptoDo>, L<Mojolicious>, L<https://mojolicious.org>.

=cut
