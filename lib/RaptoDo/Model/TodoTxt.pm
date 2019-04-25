package RaptoDo::Model::TodoTxt;
use Mojo::Base '-base';

use Mojo::File;
use RaptoDo::Model::TodoTxt::Item;

use Mojo::Collection 'c';

has path => 'todo.txt';

sub items {
  my $self = shift;

  my $file = Mojo::File->new($self->path);
  return c() if !-e $file;

  my $handle = $file->open('r');
  return c($handle->getlines)->map(sub { chomp; $_ })->map(sub {
    return RaptoDo::Model::TodoTxt::Item->new($_);
  });
}

1;

=encoding utf8

=head1 NAME

RaptoDo::Model::TodoTxt - Model for todo.txt files

=head1 SYNOPSIS

  use RaptoDo::Model::TodoTxt;

  my $collection = RaptoDo::Model::TodoTxt->new(path => 'todo.txt')->items;

=head1 DESCRIPTION

L<RaptoDo::Model::TodoTxt> is a model for todo.txt files, which provides a
simple API for reading.

=head1 ATTRIBUTES

L<RaptoDo::Model::TodoTxt> implements the following attributes.

=head2 path

  my $path = $model->path;
  $model   = $model->path('/home/owen/todo.txt');

Path to the todo.txt file to read, defaults to 'todo.txt'.

=head1 METHODS

L<RaptoDo::Model::TodoTxt> inherits all methods from L<Mojo::Base> and
implements the following new ones.

=head2 items

  my $collection = $model->items;

Reads the file at L</"path"> and returns a L<Mojo::Collection> object
containing the items as L<RaptoDo::Model::TodoTxt::Item> objects.

=head1 SEE ALSO

L<RaptoDo>, L<RaptoDo::Model::TodoTxt::Item>, L<Mojolicious>,
L<https://mojolicious.org>.

=cut
